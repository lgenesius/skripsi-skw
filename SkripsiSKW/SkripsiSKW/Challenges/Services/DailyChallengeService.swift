//
//  DailyChallengeService.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 18/01/22.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import SwiftUI
import FirebaseFirestoreSwift

class DailyChallengeService {
    static var dailyChallenge = AuthManager.db.collection("DailyChallenges")
    
    static func getDailyChallenges(completion: @escaping ([DailyChallenge]?, Error?) -> Void) {
        dailyChallenge.getDocuments { querySnapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            let badgesQueryData = querySnapshot?.documents.compactMap {
                try? $0.data(as: DailyChallenge.self)
            } ?? []
            
            completion(badgesQueryData, nil)
        }
    }
    
    static func resetDailyChallenge() {
        var userss: [User] = []
        UserService.getAllUser { users, error in
            userss = users ?? []
            dailyChallenge.getDocuments { querySnapshot, error in
                if error != nil {
                    return
                }
                
                let badgesQueryData = querySnapshot?.documents.compactMap {
                    try? $0.data(as: DailyChallenge.self)
                } ?? []
                
                for badgeQueryData in badgesQueryData {
                    dailyChallenge.document(badgeQueryData.id!).collection("Users").getDocuments { querySnapshots, error in
                        if let document = querySnapshots, !document.isEmpty {
                            var index = 0
                            for userDailyChallenge in document.documents {
                                userDailyChallenge.reference.updateData([
                                    "progress": 0,
                                    "isCompleted": false,
                                    "userId": userss[index].uid
                                ])
                                index += 1
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func updateDailyChallenge(with identifier: String, point by: Int, completion: @escaping(Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        dailyChallenge.whereField("challengeIdentifier", isEqualTo: identifier).getDocuments { querySnapshot, error in
            if let error = error {
                completion(error)
                return
            }
            
            let badgesQueryData = querySnapshot?.documents.compactMap {
                try? $0.data(as: DailyChallenge.self)
            } ?? []
            
            for badgeQueryData in badgesQueryData {
                dailyChallenge.document(badgeQueryData.id!).collection("Users").whereField("userId", isEqualTo: userId).getDocuments { (querySnapshots, error) in
                    if let error = error {
                        completion(error)
                        return
                    }
                    
                    let currentDC = badgesQueryData.first
                    
                    if let document = querySnapshots, !document.isEmpty {
                        for userDailyChallenge in document.documents {
                            let relatedUserDC = try? userDailyChallenge.data(as: DailyChallengeUserData.self)
                            if relatedUserDC!.progress + by < currentDC!.challengeGoal {
                                userDailyChallenge.reference.updateData([
                                    "progress": relatedUserDC!.progress + by
                                ])
                            } else {
                                userDailyChallenge.reference.updateData([
                                    "progress": currentDC!.challengeGoal,
                                    "isCompleted": true
                                ])
                            }
                        }
                    }
                }
            }
        }
    }
}
