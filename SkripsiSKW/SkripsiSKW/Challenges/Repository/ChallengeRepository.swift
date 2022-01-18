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
    @Published var userDailyChallenge: DailyChallengeUserData = DailyChallengeUserData(userId: "", progress: 32, isCompleted: false)
    
    init() {
        get()
    }
    
    func get() {
        DailyChallengeService.getDailyChallenges { [weak self] DailyChallenge, error in
            guard let self = self else { return }
            if error != nil {
                return
            }
            self.challenges = DailyChallenge ?? []
        }
    }
    
    func fetchUserDailyChallenge(id: String) {
        DailyChallengeService.getUserDailyChallenge(with: id) { [weak self] DailyChallengeUserDatas, error in
            guard let self = self else { return }
            if error != nil {
                return
            }
            self.userDailyChallenge = DailyChallengeUserDatas ?? DailyChallengeUserData(userId: "", progress: 32, isCompleted: false)
        }
    }
}
