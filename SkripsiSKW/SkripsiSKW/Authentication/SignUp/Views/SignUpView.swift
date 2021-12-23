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
                    .opacity(signUpVM.isValid ? 1.0 : 0.5)
                    .disabled(!signUpVM.isValid)
                    
                    Spacer()
                }
            }
            
            LoadingCard(isLoading: signUpVM.isLoading, message: "Registering Account...")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text(""))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.notYoCheese)
                    }
                }
            }
        }
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
                
                ErrorText(errorMessage: signUpVM.firstNameErrorMessage)
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
                
                ErrorText(errorMessage: signUpVM.lastNameErrorMessage)
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
                
                ErrorText(errorMessage: signUpVM.usernameErrorMessage)
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
                
                ErrorText(errorMessage: signUpVM.emailErrorMessage)
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
                
                ErrorText(errorMessage: signUpVM.passwordErrorMessage)
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
                
                ErrorText(errorMessage: signUpVM.confirmPassErrorMessage)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(signUpVM: SignUpViewModel())
    }
}
