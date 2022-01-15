//
//  UserService.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 07/01/22.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import SwiftUI

class UserService {
    static var Users = AuthManager.db.collection("Users")

    static func getUserBadges(sessionVM: SessionViewModel, completion: @escaping ([UserBadge]?, Error?) -> Void) {
        if sessionVM.authUser != nil {
            Users.document(sessionVM.authUser?.uid ?? "").collection("Badges").getDocuments { querySnapshot, error in
                if let document = querySnapshot, document.isEmpty {
                    completion(nil, error)
                    return
                }

                let userBadgesQueryData = querySnapshot?.documents.compactMap {
                    try? $0.data(as: UserBadge.self)
                } ?? []

                completion(userBadgesQueryData, nil)
            }
        }
    }
    
    static func getUserDetailBadges(userId: String, completion: @escaping([UserBadge]?, Error?) -> Void) {
        Users.document(userId).collection("Badges").getDocuments { querySnapshot, error in
            if let error = error { return completion(nil, error) }
            guard let document = querySnapshot, !document.isEmpty else { return completion(nil, error) }
            
            let userDetailBadges = document.documents.compactMap {
                try? $0.data(as: UserBadge.self)
            }
            print(userDetailBadges)
            completion(userDetailBadges, nil)
        }
    }
    
    static func getUserData(userId: String, completion: @escaping (User?, Error?) -> Void) {
        Users.document(userId).getDocument { querySnapshot, error in
            if let error = error {
                return completion(nil, error)
            }
            
            if let document = querySnapshot, document.exists {
                let relatedUserData = try? querySnapshot?.data(as: User.self)
                return completion(relatedUserData, nil)
            }
        }
    }
    
    static func updateBadge(with identifier: String, point by: Int, completion: @escaping(Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        Users.document(userId).collection("Badges").whereField("identifier", isEqualTo: identifier).getDocuments { (querySnapshot, error) in
            if let error = error {
                return completion(error)
            }
            
            if let document = querySnapshot, !document.isEmpty {
                for userBadge in document.documents {
                    let relatedUserBadge = try? userBadge.data(as: UserBadge.self)
                    if relatedUserBadge!.progress + by < relatedUserBadge!.goal {
                        userBadge.reference.updateData([
                            "progress": relatedUserBadge!.progress + by
                        ])
                    } else {
                        userBadge.reference.updateData([
                            "progress": relatedUserBadge!.progress + by,
                            "receivedDate": Date().shortDate
                        ])
                    }
                }
                return completion(nil)
            }
            
        }
    }
}
