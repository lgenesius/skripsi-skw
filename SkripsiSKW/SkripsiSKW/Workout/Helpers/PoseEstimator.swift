//
//  PoseEstimator.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 29/12/21.
//

import Foundation
import Vision
import AVFoundation
import Combine

final class PoseEstimator: NSObject, ObservableObject {
    @Published var bodyParts = [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]()
    @Published var isActive = false
    
    var workoutType: WorkoutType?
    
    private let sequenceHandler = VNSequenceRequestHandler()
    private var subscriptions = Set<AnyCancellable>()
    
    func start() {
        $bodyParts
            .dropFirst()
            .sink { [weak self] bodyParts in
                self?.doOperation(bodyParts: bodyParts)
            }
            .store(in: &subscriptions)
    }
    
    private func doOperation(bodyParts: [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]) {
        guard let workoutType = workoutType else { return }
        switch workoutType {
        case .squat:
            countSquats(bodyParts: bodyParts)
        case .plank:
            break
        case .pushup:
            break
        }
    }
    
    private func countSquats(bodyParts: [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]) {
        guard let rightKnee = bodyParts[.rightKnee]?.location,
              let leftKnee = bodyParts[.leftKnee]?.location,
              let rightHip = bodyParts[.rightHip]?.location,
              let rightAnkle = bodyParts[.rightAnkle]?.location,
              let leftAnkle = bodyParts[.leftAnkle]?.location
        else { return }
        
        print("The rightKnee ", rightKnee)
    }
    
    deinit {
        subscriptions.removeAll()
    }
}

extension PoseEstimator: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard isActive else { return }
        let humanBodyRequest = VNDetectHumanBodyPoseRequest(completionHandler: detectedBodyPose(request:error:))
        do {
            try sequenceHandler.perform([humanBodyRequest], on: sampleBuffer, orientation: .right)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func detectedBodyPose(request: VNRequest, error: Error?) {
        guard let bodyPoseResults = request.results as? [VNHumanBodyPoseObservation] else { return }
        guard let bodyParts = try? bodyPoseResults.first?.recognizedPoints(.all) else { return }
        DispatchQueue.main.async {
            self.bodyParts = bodyParts
        }
    }
}
