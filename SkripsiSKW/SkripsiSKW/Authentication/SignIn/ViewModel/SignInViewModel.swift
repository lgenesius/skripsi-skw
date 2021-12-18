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
    @Published var emailErrorMessage = ""
    @Published var passwordErrorMessage = ""
    
    func signIn() {
        isLoading = true
        
        if !validateValue() {
            return
        }
        
        AuthManager.shared.signIn(email: email, password: password) { [weak self] user, error in
            self?.isLoading = false
            if let error = error {
                self?.emailErrorMessage = error.localizedDescription
                return
            }
            
            self?.emailErrorMessage = ""
            self?.passwordErrorMessage = ""
            self?.email = ""
            self?.password = ""
        }
    }
    
    private func validateValue() -> Bool {
        emailErrorMessage = ""
        passwordErrorMessage = ""
        
        if email.isEmpty {
            emailErrorMessage = "Email must not empty"
            return false
        }
        
        if password.isEmpty {
            passwordErrorMessage = "Password must not empty"
            return false
        }
        
        if !Validator().checkEmailAuthenticity(email) {
            emailErrorMessage = "Email must contain '@' character"
            return false
        }
        
        return true
    }
}
