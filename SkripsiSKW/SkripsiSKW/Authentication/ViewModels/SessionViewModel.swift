//
//  SessionViewModel.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 13/12/21.
//

import Foundation
import Combine
import Firebase

class SessionViewModel: ObservableObject {
    @Published var authUser: User? {
        didSet {
            self.didChange.send(self)
        }
    }
    @Published var isLoading = false
    
    private var didChange = PassthroughSubject<SessionViewModel, Never>()
    private var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        isLoading = true
        handle = Auth.auth().addStateDidChangeListener({ [weak self] auth, user in
            guard let self = self else { return }
            
            if let user = user {
                let firestoreUser = AuthManager.shared.getUserDocRef(userId: user.uid)
                firestoreUser.getDocument { snapshot, error in
                    if let error = error {
                        print("Error when get document reference of user: \(error.localizedDescription)")
                        return
                    }
                    
                    if let dict = snapshot?.data() {
                        self.isLoading = false
                        guard let decodedUser = try? User.init(fromDictionary: dict) else { return }
                        self.authUser = decodedUser
                    }
                    
                    print("The Auth User ", self.authUser)
                }
            } else {
                self.isLoading = false
                self.authUser = nil
            }
        })
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error when signing out: \(error.localizedDescription)")
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}
