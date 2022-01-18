//
//  ChallengeRepository.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 05/01/22.
//

import FirebaseAuth
import Firebase
import FirebaseFirestore
import Combine

final class ChallengeRepository: ObservableObject {
    @Published var challenges: [DailyChallenge] = []
    
    init() {
        get()
    }
    
    func get() {
        DailyChallengeService.getDailyChallenges { DailyChallenge, error in
            if error != nil {
                return
            }
            self.challenges = DailyChallenge ?? []
        }
    }
}
