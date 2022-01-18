//
//  DailyChallengeViewModel.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 05/01/22.
//

import Foundation
import Combine

class DailyChallengeViewModel: ObservableObject, Identifiable {
    @Published var challenge: DailyChallenge
    @Published var dailyChallengeUserData: DailyChallengeUserData = DailyChallengeUserData(userId: "", progress: 32, isCompleted: false)
    
    @Published var dummyTotalPointPercentage: Float = 0
    @Published var dummyTotalPoint: Int = 0
    @Published var dummyChallengeGoal: Int = 0
    
    var id = ""
    private var cancellables: Set<AnyCancellable> = []
    
    private var timerSubscription: AnyCancellable? = nil
    
    deinit {
        self.timerSubscription?.cancel()
    }
    
    init(challenge: DailyChallenge) {
        self.challenge = challenge
        $challenge.compactMap {
            $0.id
        }
        .sink { [weak self] id in
            guard let self = self else { return }
            self.id = id
        }
        .store(in: &cancellables)
        
        $dummyTotalPoint
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.initTimer()
            }
            .store(in: &cancellables)
        
        self.fetchUserData()
    }
    
    private func fetchUserData() {
        DailyChallengeService.getUserDailyChallenge(with: self.id) { [weak self] dailyChallengeUserDatas, error in
            guard let self = self else { return }
            guard error == nil else { return }
            self.dailyChallengeUserData = dailyChallengeUserDatas ?? DailyChallengeUserData(userId: "", progress: 0, isCompleted: false)
            self.dummyTotalPoint = self.dailyChallengeUserData.progress
            self.dummyChallengeGoal = self.challenge.challengeGoal
            self.initTimer()
        }
    }
    
    private func initTimer() {
        self.dummyTotalPointPercentage = 0
        let point = self.dummyTotalPoint
        self.timerSubscription = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .scan(0, { (count, _) in
                return count + 1
            })
            .filter({ (count) in
                return count <= point
            })
            .sink { [weak self] timeStamp in
                guard let self = self else { return }
                self.dummyTotalPointPercentage = Float(timeStamp) / Float(self.dummyChallengeGoal)
            }
    }
}
