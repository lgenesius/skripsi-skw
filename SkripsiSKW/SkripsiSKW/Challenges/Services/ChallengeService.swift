//
//  ChallengeService.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 03/01/22.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

class ChallengeService {
    
    static var Challenges = AuthManager.db.collection("Competition")
    
//    static func ChallengesUserId(userId: String) -> DocumentReference {
//        return Challenges.document(userId)
//    }
    
    static func createChallenge(
        competitionName: String,
        competitionDescription: String,
        startDate: Date,
        endDate: Date,
        onSuccess: @escaping() -> Void,
        onError: @escaping (_ errorMessage: String) -> Void
    ) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        Challenges.addDocument(data: [
            "competitionName": competitionName,
            "competitionDescription": competitionDescription,
            "endDateEvent": startDate,
            "startDateEvent": endDate,
            "users": [
                userId
            ]
        ]) { error in
            if error == nil {
                onSuccess()
            } else {
                onError("Error")
            }
        }
        
//        let challengeId = ChallengeService.ChallengesUserId(userId: userId).collection("Competitions").document().documentID
        
    }
    
    
}
