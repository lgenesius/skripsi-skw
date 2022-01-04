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

class CompetitionService {
    
    static var Competitions = AuthManager.db.collection("Competitions")
    private static var competitions: Competition?
    
    static func createCompetition(
        competition: Competition,
        onSuccess: @escaping() -> Void,
        onError: @escaping (_ errorMessage: String) -> Void
    ) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        do {
            let newUserData = CompetitionUserData(userId: userId, userCompetitionPoint: 0)
            competitions = competition.addUserId(injectedUser: [newUserData])
            _ = try Competitions.addDocument(from: competitions)
            onSuccess()
        } catch {
            onError(error.localizedDescription)
            fatalError("Create Competition Failed")
        }
    }
    
    static func CheckValidity(completion: @escaping (Int?, Error?) -> Void){
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        Competitions.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            let competitionQueryData = querySnapshot?.documents.compactMap {
                try? $0.data(as: Competition.self)
            } ?? []
        
            let currentCompetitionUsers = competitionQueryData.filter {
                $0.users.contains { data in
                    data.userId == userId
                }
            }
            
            completion(currentCompetitionUsers.count, nil)
        }
    }
    
    static func getCompetition(completion: @escaping ([Competition]?, Error?) -> Void) {
        var competitions = [Competition]()
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        Competitions.whereField("users", arrayContains: userId).addSnapshotListener { (snapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            competitions = snapshot?.documents.compactMap {
                try? $0.data(as: Competition.self)
            } ?? []
            
            completion(competitions, nil)
        }
    }
}
