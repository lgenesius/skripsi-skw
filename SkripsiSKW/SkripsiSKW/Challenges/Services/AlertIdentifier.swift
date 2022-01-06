//
//  AlertIdentifier.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 05/01/22.
//

import Foundation

enum AlertIdentifier {
    case caution
    case openSettings
    
    var title: String {
        switch self {
        case .caution:
            return "Caution!"
        case .openSettings:
            return "Unauthorized Camera Access"
        }
    }
    
    var message: String {
        switch self {
        case .caution:
            return "You can't stop once you started your workout. Are you sure you want to start?"
        case .openSettings:
            return "You need to give permission in Settings to access camera in order to use the exercise feature."
        }
    }
    
    var primaryButtonString: String {
        return "Cancel"
    }
    
    var secondaryButtonString: String {
        switch self {
        case .caution:
            return "Start"
        case .openSettings:
            return "Open Settings"
        }
    }
}
