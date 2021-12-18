//
//  SignUpViewModel.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 13/12/21.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var firstNameErrorMessage = ""
    @Published var lastNameErrorMessage = ""
    @Published var usernameErrorMessage = ""
    @Published var emailErrorMessage = ""
    @Published var passwordErrorMessage = ""
    @Published var confirmPassErrorMessage = ""
    
    @Published var isLoading = false
    
    func signUp(completion: @escaping (() -> Void)) {
        isLoading = true
        
        if !validateValue() {
            return
        }
        
        AuthManager.shared.signUp(
            email: email,
            password: password,
            name: firstName + " " + lastName,
            username: username
        ) { [weak self] user, error in
            self?.isLoading = false
            
            if let error = error {
                self?.confirmPassErrorMessage = error.localizedDescription
                return
            }
            completion()
        }
    }
    
    private func validateValue() -> Bool {
        clearErrorMessage()
        
        if firstName.isEmpty {
            firstNameErrorMessage = "First Name must not empty"
            return false
        }
        
        if lastName.isEmpty {
            lastNameErrorMessage = "Last Name must not empty"
            return false
        }
        
        if username.isEmpty {
            usernameErrorMessage = "Username must not empty"
            return false
        }
        
        if email.isEmpty {
            emailErrorMessage = "Email must not empty"
            return false
        }
        
        if !Validator().checkEmailAuthenticity(email) {
            emailErrorMessage = "Email must contain '@'"
            return false
        }
        
        if password.isEmpty {
            passwordErrorMessage = "Password must not empty"
            return false
        }
        
        if confirmPassword.isEmpty {
            confirmPassErrorMessage = "Confirm Password must not empty"
            return false
        }
        
        if password != confirmPassword {
            confirmPassErrorMessage = "Password doesn't match"
            return false
        }
        
        return true
    }
    
    private func clearErrorMessage() {
        firstNameErrorMessage = ""
        lastNameErrorMessage = ""
        usernameErrorMessage = ""
        emailErrorMessage = ""
        passwordErrorMessage = ""
        confirmPassErrorMessage = ""
    }
}
