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
            return "Push Up"
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
    
    private var workoutTypeKey: String {
        switch self {
        case .squat:
            return "WorkoutType-Squat"
        case .plank:
            return "WorkoutType-Plank"
        case .pushup:
            return "WorkoutType-PushUp"
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
    
    func getDefaultStatus() -> Bool {
        UserDefaults.standard.bool(forKey: workoutTypeKey)
    }
    
    func setDefaultStatus(_ status: Bool) {
        UserDefaults.standard.set(status, forKey: workoutTypeKey)
    }
}
