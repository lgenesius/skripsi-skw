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
            return ""
        case .plank:
            return ""
        case .pushup:
            return ""
        }
    }
    
    var workoutDesc: String {
        switch self {
        case .squat:
            return ""
        case .plank:
            return ""
        case .pushup:
            return ""
        }
    }
    
    var benefitsDesc: String {
        switch self {
        case .squat:
            return ""
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
}
