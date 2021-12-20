//
//  SignUpViewModel.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 13/12/21.
//

import Foundation
import Combine

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
    @Published var isValid: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        isUsernameValidPublisher
            .subscribe(on: DispatchQueue(label: "background queue"))
            .receive(on: RunLoop.main)
            .map { valid in
                valid ? "" : "User name must at least have at least 3 characters"
            }
            .sink(receiveValue: { [weak self] message in
                guard let self = self else { return }
                self.usernameErrorMessage = message
            })
            .store(in: &cancellableSet)
        
        isPasswordValidPublisher
            .subscribe(on: DispatchQueue(label: "background queue"))
            .receive(on: RunLoop.main)
            .map { passwordCheck -> String in
                switch passwordCheck {
                    case .empty:
                      return "Password must not be empty"
                    case .noMatch:
                      return "Passwords don't match"
                    default:
                      return ""
                }
            }
            .sink { [weak self] passwordMessage in
                guard let self = self else { return }
                self.passwordErrorMessage = passwordMessage
            }
            .store(in: &cancellableSet)
        
        isEmailValidPublisher
            .subscribe(on: DispatchQueue(label: "background queue"))
            .receive(on: RunLoop.main)
            .map { emailCheck -> String in
                switch emailCheck {
                    case .lessThanSeven:
                        return ""
                    case .empty:
                        return ""
                    case .atNotValid:
                        return ""
                    default:
                        return ""
                } 
            }
        
        isFormValidPublisher
          .receive(on: RunLoop.main)
          .sink { [weak self] isValid in
              guard let self = self else { return }
              self.isValid = isValid
          }
          .store(in: &cancellableSet)
    }
    
    
    func signUp(completion: @escaping (() -> Void)) {
        guard validateValue() else { return }
        
        isLoading = true
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
        
        if !Validator().checkMoreThan7Chars(password) {
            passwordErrorMessage = "Password must more than 7 characters"
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

//MARK: -List of Publishers
extension SignUpViewModel {
    private var isUsernameValidPublisher: AnyPublisher<Bool, Never> {
        $username
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 3
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isUsernameValidPublisher, isPasswordValidPublisher)
          .map { userNameIsValid, passwordIsValid in
            return userNameIsValid && (passwordIsValid == .valid)
          }
        .eraseToAnyPublisher()
    }
}

//MARK: Password Validator Publishers
extension SignUpViewModel {
    enum PasswordCheck {
        case valid
        case empty
        case noMatch
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
          .debounce(for: 0.5, scheduler: RunLoop.main)
          .removeDuplicates()
          .map { password in
            return password == ""
          }
          .eraseToAnyPublisher()
    }
    
    private var arePasswordsEqualPublisher: AnyPublisher<Bool, Never> {
        $password.combineLatest($confirmPassword)
        .debounce(for: 0.2, scheduler: RunLoop.main)
          .map { password, passwordAgain in
            return password == passwordAgain
          }
          .eraseToAnyPublisher()
    }
    
    private var isPasswordValidPublisher: AnyPublisher<PasswordCheck, Never> {
        Publishers.CombineLatest(isPasswordEmptyPublisher, arePasswordsEqualPublisher)
          .map { passwordIsEmpty, passwordsAreEqual in
            if (passwordIsEmpty) {
              return .empty
            }
            else if (!passwordsAreEqual) {
              return .noMatch
            }
            else {
              return .valid
            }
          }
          .eraseToAnyPublisher()
    }
}


//MARK: Email Validator Publishers
extension SignUpViewModel {
    enum EmailCheck {
        case empty
        case lessThanSeven
        case atNotValid
        case valid
    }
    
    private var isEmailMoreThan7: AnyPublisher<Bool, Never> {
        $email
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 7
            }
            .eraseToAnyPublisher()
    }
    
    private var isEmailEmptyPublisher: AnyPublisher<Bool, Never> {
        $email
          .debounce(for: 0.5, scheduler: RunLoop.main)
          .removeDuplicates()
          .map { email in
            return email == ""
          }
          .eraseToAnyPublisher()
    }
    
    private var isEmailAtValidPublisher: AnyPublisher<Bool, Never> {
        $email
          .debounce(for: 0.5, scheduler: RunLoop.main)
          .removeDuplicates()
          .map { email in
            return Validator().checkEmailAuthenticity(email)
          }
          .eraseToAnyPublisher()
    }
    
    private var isEmailValidPublisher: AnyPublisher<EmailCheck, Never> {
        Publishers.CombineLatest3(isEmailMoreThan7, isEmailEmptyPublisher, isEmailAtValidPublisher)
            .map { emailMoreThan7, emailIsEmpty, emailIsAtValid in
                if (!emailMoreThan7) {
                    return .lessThanSeven
                } else if (emailIsEmpty) {
                    return .empty
                } else if (!emailIsAtValid) {
                    return .atNotValid
                } else {
                    return .valid
                }
            }
            .eraseToAnyPublisher()
    }
}
