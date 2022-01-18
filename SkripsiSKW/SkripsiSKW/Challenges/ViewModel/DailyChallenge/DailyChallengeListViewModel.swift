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
    
    private var cancellables: Set<AnyCancellable> = []
    
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
