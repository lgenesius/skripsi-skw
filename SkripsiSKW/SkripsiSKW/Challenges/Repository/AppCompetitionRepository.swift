//
//  AppCompetitionRepository.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 05/01/22.
//

import FirebaseAuth
import Firebase
import FirebaseFirestore
import Combine

final class AppCompetitionRepository: ObservableObject {
    @Published var appCompetitions: [AppCompetition] = []
    
    init() {
        get()
    }
    
    func get() {
        
    }
}
