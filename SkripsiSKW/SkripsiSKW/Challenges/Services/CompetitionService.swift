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
            competitions = competition.addUserId(userId: [userId])
            _ = try Competitions.addDocument(from: competitions)
            onSuccess()
        } catch {
            onError(error.localizedDescription)
            fatalError("Create Competition Failed")
        }
    }
    
    static func CheckValidity(completion: @escaping (Int?, Error?) -> Void){
        var data = [QueryDocumentSnapshot]()
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        Competitions.whereField("users", arrayContains: userId)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    completion(nil, err)
                    
                } else {
                    _ = querySnapshot?.documents.map {
                        data.append($0)
                    }
                    
                    completion(data.count, nil)
                }
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
