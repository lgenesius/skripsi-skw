//
//  WorkoutType.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 24/12/21.
//

import SwiftUI

enum WorkoutType {
    case squat
    case plank
    case pushup
    
    var title: String {
        switch self {
        case .squat:
            return "Squat"
        case .plank:
            return "Plank Hip Raise"
        case .pushup:
            return "PushUp"
        }
    }
    
    var imageString: String {
        switch self {
        case .squat:
            return "dummy"
        case .plank:
            return "dummy"
        case .pushup:
            return "dummy"
        }
    }
    
    var workoutTitleInfo: String {
        switch self {
        case .squat:
            return "Squat Exercise Guide"
        case .plank:
            return "Plank Hip Raise Guide"
        case .pushup:
            return "Push Up Exercise Guide"
        }
    }
    
    var workoutDesc: String {
        switch self {
        case .squat:
            return "During squat exercise, please face the front of camera in order to detect your body pose accurately and don't be too far from the camera (just until all your body is detected)."
        case .plank:
            return "During plank exercise, please facing the side of camera in order to detect your body pose accurately and don't be too far from the camera (just until all your body is detected)."
        case .pushup:
            return "During pushup exercise, please facing the side of camera in order to detect your body pose accurately and don't be too far from the camera (just until all your body is detected)."
        }
    }
    
    var infoImageString: String {
        switch self {
        case .squat:
            return "squatInfo"
        case .plank:
            return "plankInfo"
        case .pushup:
            return "pushupInfo"
        }
    }
    
    var placeholderImage: String {
        switch self {
        case .squat:
            return "placeholderImage2"
        case .plank:
            return "placeholderImage3"
        case .pushup:
            return "placeholderImage"
        }
    }
    
    var benefitsDesc: String {
        switch self {
        case .squat:
            return "The benefits are to strengthens your core, reduces the risk of injury, crushes calories, and boost athletic ability and strength."
        case .plank:
            return "The benefits are improve your posture, can help reduce low back pain, enhance your balance  and can lead to increase flexibility."
        case .pushup:
            return "The benefits are to improve your posture, strengthens your core, improve upper-body strength, improve heart health, and strengthen your bones."
        }
    }
    
    var orientation: ViewOrientation {
        switch self {
        case .squat:
            return .portrait
        case .plank:
            return .landscape
        case .pushup:
            return .landscape
        }
    }
    
    private var workoutTypeKey: String {
        switch self {
        case .squat:
            return "WorkoutType-Squat-Info"
        case .plank:
            return "WorkoutType-Plank-Info"
        case .pushup:
            return "WorkoutType-PushUp-Info"
        }
    }
    
    func getDefaultStatus() -> Bool {
        UserDefaults.standard.bool(forKey: workoutTypeKey)
    }
    
    func setDefaultStatus(_ status: Bool) {
        UserDefaults.standard.set(status, forKey: workoutTypeKey)
    }
}
