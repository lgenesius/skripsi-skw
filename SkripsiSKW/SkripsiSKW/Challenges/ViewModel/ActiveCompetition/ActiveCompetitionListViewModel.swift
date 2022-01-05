//
//  ActiveCompetitionViewModel.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 05/01/22.
//

import Combine

final class ActiveCompetitionListViewModel: ObservableObject {
    @Published private var competitionRepository = CompetitionRepository()
    @Published var competitionListModel: [ActiveCompetitionViewModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        competitionRepository.$competitions
            .map { competitions in
                competitions.map(ActiveCompetitionViewModel.init)
            }
            .sink { [weak self] competitions in
                guard let self = self else { return }
                self.competitionListModel = competitions
            }
            .store(in: &cancellables)
    }
    
    func fetchData() {
        competitionRepository.get()
    }
    
    
}
