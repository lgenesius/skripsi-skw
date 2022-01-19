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
            countPlank(bodyParts: bodyParts)
        case .pushup:
            countPushUp(bodyParts: bodyParts)
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
        
        let diff = hipHeight - kneeHeight
        
        if diff < 0.1 {
            self.wasInBottomPosition = true
        }
    }
    private func countPlank(bodyParts: [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]) {
        guard let rightKnee = bodyParts[.rightKnee]?.location,
              let leftKnee = bodyParts[.leftKnee]?.location,
              let rightHip = bodyParts[.rightHip]?.location,
              let rightAnkle = bodyParts[.rightAnkle]?.location,
              let leftAnkle = bodyParts[.leftAnkle]?.location,
              let rightShoulder = bodyParts[.rightShoulder]?.location,
              let rightElbow = bodyParts[.rightElbow]?.location,
              let rightWrist = bodyParts[.rightWrist]?.location
        else { return }
        var feetAboveWrist = false
        var kneeAboveWrist = false
        var kneeAboveAnkle = false
        let firstElbowAngle = atan2(rightShoulder.y - rightElbow.y, rightShoulder.x - rightElbow.x)
        let secondElbowAngle = atan2(rightWrist.y - rightElbow.y, rightWrist.x - rightElbow.x)
        var elbowAngleDiffRadians = firstElbowAngle - secondElbowAngle
        while elbowAngleDiffRadians < 0 {
            elbowAngleDiffRadians += CGFloat(2 * Double.pi)
        }
        let elbowAngleDiffDegrees = Int(elbowAngleDiffRadians * 180 / .pi)
        
        let firstHipAngle = atan2(rightShoulder.y - rightHip.y, rightShoulder.x - rightHip.x)
        let secondHipAngle = atan2(rightKnee.y - rightHip.y, rightKnee.x - rightHip.x)
        var hipAngleDiffRadians = firstHipAngle - secondHipAngle
        while hipAngleDiffRadians < 0 {
            hipAngleDiffRadians += CGFloat(2 * Double.pi)
        }
        
        let hipAngleDiffDegrees = Int(hipAngleDiffRadians * 180 / .pi)
     
        if rightKnee.y > rightWrist.y {
            kneeAboveWrist = true //ketika naik pantatnya
        }else{
            kneeAboveWrist = false
        }
        if rightKnee.y > rightAnkle.y {
            kneeAboveAnkle = true
        }else{
            kneeAboveAnkle = false
        }
        if elbowAngleDiffDegrees > 75 && hipAngleDiffDegrees > 150  && self.wasInBottomPosition && kneeAboveAnkle && kneeAboveWrist  {  // was in bottom itu posisi pantat angkat , jadi ini pas pantat turun dan pantat sudah naik
            self.count += 1
            self.wasInBottomPosition = false
        }
        
        if elbowAngleDiffDegrees > 75 && hipAngleDiffDegrees < 130 && kneeAboveAnkle && kneeAboveWrist {  // was in bottom itu posisi pantat angkat , jadi ini buat cek pantat uda naik blm
            
            self.wasInBottomPosition = true
        }
        
    }
    private func countPushUp(bodyParts: [VNHumanBodyPoseObservation.JointName: VNRecognizedPoint]) {
        guard let rightKnee = bodyParts[.rightKnee]?.location,
              let leftKnee = bodyParts[.leftKnee]?.location,
              let rightHip = bodyParts[.rightHip]?.location,
              let rightAnkle = bodyParts[.rightAnkle]?.location,
              let leftAnkle = bodyParts[.leftAnkle]?.location,
              let rightShoulder = bodyParts[.rightShoulder]?.location,
              let rightElbow = bodyParts[.rightElbow]?.location,
              let rightWrist = bodyParts[.rightWrist]?.location
        else { return }
        var feetAboveWrist = false
        var kneeAboveWrist = false
        var kneeAboveAnkle = false
        let firstElbowAngle = atan2(rightShoulder.y - rightElbow.y, rightShoulder.x - rightElbow.x)
        let secondElbowAngle = atan2(rightWrist.y - rightElbow.y, rightWrist.x - rightElbow.x)
        var elbowAngleDiffRadians = firstElbowAngle - secondElbowAngle
        while elbowAngleDiffRadians < 0 {
            elbowAngleDiffRadians += CGFloat(2 * Double.pi)
        }
        let elbowAngleDiffDegrees = Int(elbowAngleDiffRadians * 180 / .pi)
        
        if rightAnkle.y > rightWrist.y {
            feetAboveWrist = true //ketika naik pantatnya
        }else{
            feetAboveWrist = false
        }
        if rightKnee.y > rightWrist.y {
            kneeAboveWrist = true //ketika naik pantatnya
        }else{
            kneeAboveWrist = false
        }
        if rightKnee.y > rightAnkle.y {
            kneeAboveAnkle = true
        }else{
            kneeAboveAnkle = false
        }
        if elbowAngleDiffDegrees < 100 && self.wasInBottomPosition {  // was in bottom itu posisi TANGAN angkat , jadi ini pas TANGAN posisi dorong keatas atau posisi push kemudian  TANGAN sudah turun ke posisi semula
            self.count += 1
            self.wasInBottomPosition = false
        }
        
        if elbowAngleDiffDegrees > 160 && kneeAboveAnkle {  // was in bottom itu posisi TANGAN angkat , jadi ini buat cek TANGAN uda naik blm
            
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
