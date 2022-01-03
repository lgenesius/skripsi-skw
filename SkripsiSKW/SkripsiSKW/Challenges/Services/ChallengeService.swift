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
    
    static var Challenges = AuthManager.db.collection("Competitions")

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
            "startDateEvent": startDate,
            "endDateEvent": endDate,
            "users": [
                userId
            ],
            "isRunning": true
        ]) { error in
            if error == nil {
                onSuccess()
            } else {
                onError(error?.localizedDescription ?? "Error")
            }
        }
    }
    
    static func CheckValidity() -> Bool{
        
        return true
    }
}
