//
//  ActiveCompetitionViewModel.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 05/01/22.
//

import Combine

final class ActiveCompetitionViewModel: ObservableObject, Identifiable {
    private let competitionRepository = CompetitionRepository()
    @Published var competition: Competition
    
    var id = ""
    private var cancellables: Set<AnyCancellable> = []
    
    init(competition: Competition) {
        self.competition = competition
        $competition.compactMap {
            $0.id
        }
        .sink { [weak self] id in
            guard let self = self else { return }
            self.id = id
        }
        .store(in: &cancellables)
    }
}
