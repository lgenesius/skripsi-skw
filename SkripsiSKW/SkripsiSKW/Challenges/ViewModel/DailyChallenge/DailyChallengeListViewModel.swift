//
//  DailyChallengeListViewModel.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 05/01/22.
//

import Foundation

class DailyChallengeListViewModel: ObservableObject {
    @Published private var competitionRepository = ChallengeRepository()
    @Published var dailyChallengeListModel: [DailyChallengeViewModel] = []
}
