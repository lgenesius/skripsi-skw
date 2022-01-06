//
//  StorageService.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 06/01/22.
//

import FirebaseAuth
import Firebase
import FirebaseFirestore
import Combine

class StorageService {
    static var storage = Storage.storage()
    
    static var storageRoot = storage.reference()
    
    static var storageBadges = storageRoot.child("Asset/Badge")
    
    static func storageBadgeId(badgeId: String) -> StorageReference {
        return storageBadges.child(badgeId)
    }
    
//    static func saveUserBadgeData
}
