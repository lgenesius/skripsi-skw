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
}
