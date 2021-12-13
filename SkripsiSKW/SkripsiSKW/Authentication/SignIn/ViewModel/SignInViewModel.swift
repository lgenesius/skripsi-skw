//
//  SignInViewModel.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 13/12/21.
//

import Foundation

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published var isLoading = false
    
    func signIn() {
        isLoading = true
        AuthManager.shared.signIn(email: email, password: password) { [weak self] user, error in
            self?.isLoading = false
            print(error)
        }
    }
}
