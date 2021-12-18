//
//  SignUpView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 11/12/21.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var sessionVM: SessionViewModel
    
    @ObservedObject var signUpVM: SignUpViewModel
    
    var body: some View {
        ZStack {
            Color.sambucus
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color.notYoCheese)
                                .frame(width: 20, height: 20)
                        }
                        Spacer()
                    }
                    .padding(.leading)
                    
                    Text("Let's Get Started!")
                        .font(Font.system(size: 24, weight: .medium, design: .default))
                        .foregroundColor(.white)
                    
                    signUpTextField
                    
                    signUpSecureField
                    
                    RoundedButton(title: "Register") {
                        signUpVM.signUp {
                            sessionVM.listen()
                            
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

extension SignUpView {
    
    @ViewBuilder
    var signUpTextField: some View {
        Group {
            Group {
                HStack {
                    Text("First Name")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 25)
                
                FormField(value: $signUpVM.firstName, placeholder: "Enter your first name...")
                
                if !signUpVM.firstNameErrorMessage.isEmpty {
                    ErrorText(errorMessage: signUpVM.firstNameErrorMessage)
                }
            }
            
            Group {
                HStack {
                    Text("Last Name")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 10)
                
                FormField(value: $signUpVM.lastName, placeholder: "Enter your last name...")
                
                if !signUpVM.lastNameErrorMessage.isEmpty {
                    ErrorText(errorMessage: signUpVM.lastNameErrorMessage)
                }
            }
            
            Group {
                HStack {
                    Text("Username")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 10)
                
                FormField(value: $signUpVM.username, placeholder: "Enter your username...")
                
                if !signUpVM.usernameErrorMessage.isEmpty {
                    ErrorText(errorMessage: signUpVM.usernameErrorMessage)
                }
            }
            
            Group {
                HStack {
                    Text("Email")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 10)
                
                FormField(value: $signUpVM.email, placeholder: "Enter your email...")
                
                if !signUpVM.emailErrorMessage.isEmpty {
                    ErrorText(errorMessage: signUpVM.emailErrorMessage)
                }
            }
        }
    }
    
    @ViewBuilder
    var signUpSecureField: some View {
        Group {
            Group {
                HStack {
                    Text("Password")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 10)
                
                FormField(value: $signUpVM.password, placeholder: "Enter your password...", isSecure: true)
                
                if !signUpVM.passwordErrorMessage.isEmpty {
                    ErrorText(errorMessage: signUpVM.passwordErrorMessage)
                }
            }
            
            Group {
                HStack {
                    Text("Re-type Password")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 10)
                
                FormField(value: $signUpVM.confirmPassword, placeholder: "Re-enter your password...", isSecure: true)
                
                if !signUpVM.confirmPassErrorMessage.isEmpty {
                    ErrorText(errorMessage: signUpVM.confirmPassErrorMessage)
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(signUpVM: SignUpViewModel())
    }
}
