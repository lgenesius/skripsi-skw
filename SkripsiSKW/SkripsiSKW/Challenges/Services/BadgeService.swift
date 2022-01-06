//
//  BadgeService.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 06/01/22.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import SwiftUI

class BadgeService {
    static var Badges = AuthManager.db.collection("Badges")
    
    static func addBadge(
        badge: Badge,
        onSuccess: @escaping() -> Void,
        onError: @escaping (_ errorMessage: String) -> Void
    ) {
        do {
            _ = try Badges.addDocument(from: badge)
            onSuccess()
        } catch {
            onError(error.localizedDescription)
            fatalError("Create Competition Failed")
        }
    }
    
    static func getBadge(completion: @escaping ([Badge]?, Error?) -> Void) {
        Badges.getDocuments { querySnapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            let badgesQueryData = querySnapshot?.documents.compactMap {
                try? $0.data(as: Badge.self)
            } ?? []
            
            completion(badgesQueryData, nil)
        }
    }
}
