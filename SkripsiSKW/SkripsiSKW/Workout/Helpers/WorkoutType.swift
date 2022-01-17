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
            return "Plank"
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
            return "Facing the Front of Camera"
        case .plank:
            return "Facing the side of Camera"
        case .pushup:
            return "Facing the side of Camera"
        }
    }
    
    var workoutDesc: String {
        switch self {
        case .squat:
            return "During squat exercise, please facing the front of camera in order to detect your body pose accurately."
        case .plank:
            return "During plank exercise, please facing the side of camera in order to detect your body pose accurately."
        case .pushup:
            return "During pushup exercise, please facing the side of camera in order to detect your body pose accurately."
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
