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
        CompetitionService.getCompetition { competitions, error in
            if error != nil {
                return
            }
            self.competitions = competitions ?? []
        }
    }
    
    func add(_ competition: Competition,  onSuccess: @escaping() -> Void,
             onError: @escaping (_ errorMessage: String) -> Void, sessionVM: SessionViewModel) {
        
        CompetitionService.createCompetition(competition: competition, onSuccess: {
            onSuccess()
        }, onError: { errorMessage in
            onError(errorMessage)
        }, sessionVM: sessionVM)
        
    }
}


