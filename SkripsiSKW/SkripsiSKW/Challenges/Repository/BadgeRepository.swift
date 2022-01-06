//
//  BadgeRepository.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 06/01/22.
//

import FirebaseAuth
import Firebase
import FirebaseFirestore
import Combine

final class BadgeRepository: ObservableObject {
    @Published var badges: [Badge] = []
    
    init() {
//        get()
    }
    
    private func addData(badge: Badge) {
        BadgeService.addBadge(badge: badge) {
            
        } onError: { errorMessage in
            
        }
    }
    
    func getBadges() {
        
    }
}
