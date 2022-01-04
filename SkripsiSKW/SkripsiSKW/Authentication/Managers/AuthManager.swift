//
//  AuthManager.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 13/12/21.
//

import Foundation
import Firebase

class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    static var db = Firestore.firestore()
    
    func getUserDocRef(userId: String) -> DocumentReference {
        return Firestore.firestore().collection("Users").document(userId)
    }
    
    func signUp(
        email: String,
        password: String,
        name: String,
        username: String,
        completion: @escaping (User?, Error?) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authDataResult, error in
            if let error = error { completion(nil, error) }
            guard let self = self, let userId = authDataResult?.user.uid else { return }
            
            if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                changeRequest.displayName = username
                changeRequest.commitChanges { error in
                    if let error = error {
                        completion(nil, error)
                    }
                    
                    let firestoreDocReference = self.getUserDocRef(userId: userId)
                    let user = User(uid: userId, email: email, name: name, username: username, badges: [:], challenges: [])
                    
                    guard let dict = try? user.asDictionary() else { return }
                    firestoreDocReference.setData(dict) { error in
                        if let error = error {
                            completion(nil, error)
                        }
                    }
                    
                    completion(user, nil)
                }
            }
        }
    }
    
    func signIn(
        email: String,
        password: String,
        completion: @escaping (User?, Error?) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authData, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(nil, error)
            }
            
            guard let userId = authData?.user.uid else { return }
            
            let firestoreUser = self.getUserDocRef(userId: userId)
            firestoreUser.getDocument { document, error in
                if let error = error { completion(nil, error) }
                
                if let dict = document?.data() {
                    guard let decodedUser = try? User.init(fromDictionary: dict) else { return }
                    completion(decodedUser, nil)
                }
            }
        }
    }
}
