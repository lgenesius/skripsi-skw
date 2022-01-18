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
    @Published private var badges: [Badge] = []
    @Published var userBadges: [UserBadge] = []
    
    init() {
  
    }
    
    private func addData(badge: Badge) {
        BadgeService.addBadge(badge: badge) {
            
        } onError: { errorMessage in
            
        }
    }
    
    func getBadges() {
        
    }
    
    func getUserBadges(sessionVM: SessionViewModel) {
        UserService.getUserBadges(sessionVM: sessionVM) { [weak self] userBadges, error in
            guard let self = self else { return }
            if error != nil {
                return
            }
            self.userBadges = userBadges ?? []
        }
    }
    
    func getUserDetailBadges(userId: String) {
        UserService.getUserDetailBadges(userId: userId) { [weak self] userBadges, error in
            guard let self = self else { return }
            if error != nil {
                return
            }
            self.userBadges = userBadges ?? []
        }
    }
}
