//
//  ChallengeRepository.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 05/01/22.
//

import FirebaseAuth
import Firebase
import FirebaseFirestore
import Combine

final class ChallengeRepository: ObservableObject {
    @Published var challenges: [Challenge] = []
    
    init() {
        get()
    }
    
    func get() {
        
    }
}
