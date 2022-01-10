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
    
    private var userID: String = ""
    private var cancellables: Set<AnyCancellable> = []
    
    init(_ userID: String) {
        competitionRepository.$competitions
            .map { competitions in
                competitions.map { Competition in
                    ActiveCompetitionViewModel.init(competition: Competition, userId: userID)
                }
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
    
    func updateAllData(by points: Int){
        competitionListModel.forEach {
            CompetitionService.updateCompetitionData(competitionPoint: points, onSuccess: {
                
            }, onError: { String in
                
            }, competitionId: $0.id)
        }
        
        fetchData()
    }
}
