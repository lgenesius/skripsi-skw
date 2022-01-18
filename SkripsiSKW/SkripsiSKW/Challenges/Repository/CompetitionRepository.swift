//
//  CompetitionRepository.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 04/01/22.
//

import FirebaseAuth
import Firebase
import FirebaseFirestore
import Combine

final class CompetitionRepository: ObservableObject {
    @Published var competitions: [Competition] = []
    
    init() {
        get()
    }
    
    func get() {
        CompetitionService.getCompetition { [weak self] competitions, error in
            guard let self = self else { return }
            if error != nil {
                return
            }
            self.competitions = competitions ?? []
        }
    }
    
    func createCompetition(_ competition: Competition, sessionVM: SessionViewModel,  onSuccess: @escaping() -> Void,
             onError: @escaping (_ errorMessage: String) -> Void) {

        CompetitionService.createCompetition(competition: competition, onSuccess: {
            onSuccess()
        }, onError: { errorMessage in
            onError(errorMessage)
        }, sessionVM: sessionVM)

    }
    
    func getOutOfCompetition(_ competitionId: String, onSuccess: @escaping() -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        CompetitionService.leaveCompetition(competitionId) {
            onSuccess()
        } onError: { errorMessage in
            onError(errorMessage)
        }
    }
    
    func updateCompetitionData(_ competitionId: String, sessionVM: SessionViewModel, onSuccess: @escaping() -> Void,
                               onError: @escaping (_ errorMessage: String) -> Void )
    {
        
    }
}
