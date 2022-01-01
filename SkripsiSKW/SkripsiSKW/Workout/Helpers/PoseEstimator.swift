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
import UIKit

final class PoseEstimator: NSObject, ObservableObject {
    @Published var bodyParts = [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]()
    @Published var isActive = false
    
    @Published var timeRemaining = 0
    @Published var count = 0
    
    var workoutType: WorkoutType?
    
    private var wasInBottomPosition = false
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
    
    func getWorkoutSeconds() -> Int {
        guard let workoutType = workoutType else { return 0 }
        switch workoutType {
        case .squat:
            return 45
        case .plank:
            return 45
        case .pushup:
            return 45
        }
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
        
        let firstAngle = atan2(rightHip.y - rightKnee.y, rightHip.x - rightKnee.x)
        let secondAngle = atan2(rightAnkle.y - rightKnee.y, rightAnkle.x - rightKnee.x)
        var angleDiffRadians = firstAngle - secondAngle
        while angleDiffRadians < 0 {
            angleDiffRadians += CGFloat(2 * Double.pi)
        }
        let angleDiffDegrees = Int(angleDiffRadians * 180 / .pi)
        if angleDiffDegrees > 150 && self.wasInBottomPosition {
            self.count += 1
            self.wasInBottomPosition = false
        }
        
        let hipHeight = rightHip.y
        let kneeHeight = rightKnee.y
        if hipHeight < kneeHeight {
            self.wasInBottomPosition = true
        }
    }
    
    deinit {
        subscriptions.removeAll()
    }
}

extension PoseEstimator: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard isActive, let orientation = workoutType?.orientation else { return }
        let humanBodyRequest = VNDetectHumanBodyPoseRequest(completionHandler: detectedBodyPose(request:error:))
        do {
            if orientation == .portrait {
                try sequenceHandler.perform([humanBodyRequest], on: sampleBuffer, orientation: .right)
            } else {
                if UIDevice.current.orientation == .landscapeLeft {
                    try sequenceHandler.perform([humanBodyRequest], on: sampleBuffer, orientation: .down)
                } else {
                    try sequenceHandler.perform([humanBodyRequest], on: sampleBuffer)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func detectedBodyPose(request: VNRequest, error: Error?) {
        guard let bodyPoseResults = request.results as? [VNHumanBodyPoseObservation] else { return }
        guard let bodyParts = try? bodyPoseResults.first?.recognizedPoints(.all) else { return }
        DispatchQueue.main.async { [weak self] in
            self?.bodyParts = bodyParts
        }
    }
}
