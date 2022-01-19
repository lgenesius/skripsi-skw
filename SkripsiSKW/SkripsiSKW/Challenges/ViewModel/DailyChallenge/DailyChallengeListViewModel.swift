//
//  DailyChallengeListViewModel.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 05/01/22.
//

import Foundation
import Combine

class DailyChallengeListViewModel: ObservableObject {
    @Published private var challengeRepository = ChallengeRepository()
    @Published var dailyChallengeListModel: [DailyChallengeViewModel] = []
    @Published var selectedDailyChallengeVM: DailyChallengeViewModel = DailyChallengeViewModel(challenge: DailyChallenge(challengeName: "", challengeDescription: "", challengeCompletion: 0, challengeGoal: 0, challengeIdentifier: ""))
    @Published var showDailyChallengeDetail: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    func selectBadgeViewModel(dailyChallengeVM: DailyChallengeViewModel) {
        self.selectedDailyChallengeVM = dailyChallengeVM
    }
    
    init() {
        challengeRepository.$challenges
            .map {
                $0.map {
                    DailyChallengeViewModel.init(challenge: $0)
                }
            }
            .sink { [weak self] competitions in
                guard let self = self else { return }
                self.dailyChallengeListModel = competitions
            }
            .store(in: &cancellables)
    }
    
    func fetchData() {
        challengeRepository.get()
    }
}
