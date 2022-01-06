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
        Users.document(sessionVM.authUser?.uid ?? "").collection("Badges").getDocuments { querySnapshot, error in
            if let document = querySnapshot, document.isEmpty {
                completion(nil, error)
                return
            }
            
            let userBadgesQueryData = querySnapshot?.documents.compactMap {
                try? $0.data(as: UserBadge.self)
            } ?? []
            
            print(userBadgesQueryData)
            
            completion(userBadgesQueryData, nil)
        }
    }
}
