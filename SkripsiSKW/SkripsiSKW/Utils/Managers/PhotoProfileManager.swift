//
//  PhotoProfileManager.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 07/01/22.
//

import Foundation
import Firebase

final class PhotoProfileManager {
    static let shared = PhotoProfileManager()
    
    private let storageProfile = Storage.storage().reference().child("profile")
    
    func getProfileImageStorageReference(profileId: String) -> StorageReference {
        return storageProfile.child(profileId)
    }
    
    func savePhoto(
        userId: String,
        imageData: Data,
        completion: @escaping (String, Error?) -> Void
    ) {
        let storagePostRef = getProfileImageStorageReference(profileId: userId)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storagePostRef.putData(imageData, metadata: metaData) { storageMetaData, error in
            if let error = error {
                completion("", error)
                return
            }
            
            storagePostRef.downloadURL { url, error in
                if let metaImageUrl = url?.absoluteString {
                    completion(metaImageUrl, nil)
                }
            }
        }
    }
    
    func deletePhoto(userId: String, completion: @escaping (Error?) -> Void) {
        let storagePostRef = getProfileImageStorageReference(profileId: userId)
        storagePostRef.delete { error in
            completion(error)
        }
    }
}
