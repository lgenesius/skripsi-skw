//
//  DailyChallengeViewModel.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 05/01/22.
//

import Foundation
import Combine

class DailyChallengeViewModel: ObservableObject, Identifiable {
    @Published var challenge: Challenge
    
    var id = ""
    private var cancellables: Set<AnyCancellable> = []
    
    init(challenge: Challenge) {
        self.challenge = challenge
        $challenge.compactMap {
            $0.id
        }
        .sink { [weak self] id in
            guard let self = self else { return }
            self.id = id
        }
        .store(in: &cancellables)
    }
}
