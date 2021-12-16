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
    
    @Published var isLoading = false
    
    func signUp() {
        isLoading = true
        AuthManager.shared.signUp(
            email: email,
            password: password,
            name: firstName + " " + lastName,
            username: username
        ) { [weak self] user, error in
            self?.isLoading = false
            print(error)
        }
    }
}
