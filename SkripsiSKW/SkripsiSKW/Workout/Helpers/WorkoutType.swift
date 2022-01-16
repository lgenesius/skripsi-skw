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
    
    var workoutDesc: String {
        switch self {
        case .squat:
            return "A good warm-up before a workout dilates your blood vessels, ensuring that your muscles are well supplied with oxygen."
        case .plank:
            return ""
        case .pushup:
            return ""
        }
    }
    
    var benefitsDesc: String {
        switch self {
        case .squat:
            return "A good warm-up before a workout dilates your blood vessels, ensuring that your muscles are well supplied with oxygen."
        case .plank:
            return ""
        case .pushup:
            return ""
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
