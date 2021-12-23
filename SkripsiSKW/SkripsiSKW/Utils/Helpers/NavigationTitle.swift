//
//  NavigationTitle.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 22/12/21.
//

import Foundation

enum NavigationTitle {
    case challenges
    case competition
    
    var title: String {
        switch self {
        case .challenges:
            return "Challenges"
        case .competition:
            return "Competition"
        }
    }
}
