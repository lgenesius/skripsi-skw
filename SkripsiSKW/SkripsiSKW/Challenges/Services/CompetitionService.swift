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
import SwiftUI

class CompetitionService {
    static var Competitions = AuthManager.db.collection("Competitions")
    private static var competitions: Competition?
    
    static func createCompetition(
        competition: Competition,
        onSuccess: @escaping() -> Void,
        onError: @escaping (_ errorMessage: String) -> Void,
        sessionVM: SessionViewModel
    ) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        do {
            let newUserData = CompetitionUserData(userId: userId, userCompetitionPoint: 0, userName: sessionVM.authUser?.name ?? "Nil")
            competitions = competition.addUserId(injectedUser: [newUserData])
            _ = try Competitions.addDocument(from: competitions)
            onSuccess()
        } catch {
            onError(error.localizedDescription)
            fatalError("Create Competition Failed")
        }
    }
    
    static func CheckSameCompetition(_ competitionCode: String, completion: @escaping (Bool, Error?) -> Void) {
        var result = false
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        Competitions.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(result, error)
                return
            }
            
            let competitionQueryData = querySnapshot?.documents.compactMap {
                try? $0.data(as: Competition.self)
            } ?? []
        
            let currentCompetitionUsers = competitionQueryData.filter { competitionData in
                competitionData.users.contains { data in
                    data.userId == userId && competitionData.competitionCode == competitionCode
                }
            }
            result = currentCompetitionUsers.count < 1 ? false : true
            completion(result, nil)
        }
        
    }
    
    static func JoinCompetition(_ competitionCode: String, sessionVM: SessionViewModel, completion: @escaping (JoinChallengeEnum, Error?) -> Void){
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        Competitions.whereField("competitionCode", isEqualTo: competitionCode).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.error, error)
                return
            }
            
            if let document = querySnapshot, document.isEmpty {
                completion(.inValid, nil)
                return
            }
            
            CheckSameCompetition(competitionCode) { isSame, error in
                if isSame {
                    completion(.insideTheCompetition, nil)
                    return }
                else {
                    CheckValidity { competitionJoined, error in
                        if error != nil {
                            completion(.error, error)
                            return
                        }

                        if let data = competitionJoined, data == 2 {
                            completion(.moreThanTwo, nil)
                            return
                        }
                        else {
                            let document = querySnapshot!.documents.first
                            document?.reference.updateData([
                                "users": FieldValue.arrayUnion([[
                                    "userCompetitionPoint" : 0,
                                    "userId" : userId,
                                    "userName": sessionVM.authUser?.name ?? "Nil"
                                ]])
                            ])
                            completion(.valid, nil)
                            return
                        }
                    }
                }
            }
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
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        Competitions.order(by: "users", descending: true).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            let competitionQueryData = querySnapshot?.documents.compactMap {
                try? $0.data(as: Competition.self)
            } ?? []
        
            let currentCompetition = competitionQueryData.filter { competitionData in
                competitionData.users.contains { data in
                    data.userId == userId
                }
            }
            completion(currentCompetition, nil)
        }
    }
    
    static func leaveCompetition(_ competitionId: String, onSuccess: @escaping() -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
            guard let userId = Auth.auth().currentUser?.uid else {
                return
            }
            
            Competitions.document(competitionId).getDocument { (document, error) in
                if let document = document, document.exists {
                    let competitionQueryData = try? document.data(as: Competition.self)
                    var users = competitionQueryData?.users
                    
                    users = users!.filter { $0.userId == userId }
                    let newUser = [
                        "userId": users!.first!.userId,
                        "userCompetitionPoint": users!.first!.userCompetitionPoint,
                        "userName": users!.first!.userName,
                    ] as [String : Any]
                    
                    document.reference.updateData([
                        "users": FieldValue.arrayRemove([newUser])
                    ])
                    
                    onSuccess()
                } else {
                    onError("Document does not exist")
                }
            }
        }
}

