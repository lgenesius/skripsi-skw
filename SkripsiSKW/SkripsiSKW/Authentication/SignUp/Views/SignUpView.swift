//
//  SignUpView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 11/12/21.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject private var signUpVM = SignUpViewModel()
    
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
                        signUpVM.signUp()
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
            VStack(spacing: 5) {
                HStack {
                    Text("First Name")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                
                FormField(value: $signUpVM.firstName, placeholder: "Enter your first name...")
            }
            .padding(.top, 25)
            
            VStack(spacing: 5) {
                HStack {
                    Text("Last Name")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                
                FormField(value: $signUpVM.lastName, placeholder: "Enter your last name...")
            }
            .padding(.top, 10)
            
            VStack(spacing: 5) {
                HStack {
                    Text("Username")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                
                FormField(value: $signUpVM.username, placeholder: "Enter your username...")
            }
            .padding(.top, 10)
            
            VStack(spacing: 5) {
                HStack {
                    Text("Email")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                
                FormField(value: $signUpVM.email, placeholder: "Enter your email...")
            }
            .padding(.top, 10)
        }
    }
    
    @ViewBuilder
    var signUpSecureField: some View {
        Group {
            VStack(spacing: 5) {
                HStack {
                    Text("Password")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                
                FormField(value: $signUpVM.password, placeholder: "Enter your password...", isSecure: true)
            }
            .padding(.top, 10)
            
            VStack(spacing: 5) {
                HStack {
                    Text("Re-type Password")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                
                FormField(value: $signUpVM.confirmPassword, placeholder: "Re-enter your password...", isSecure: true)
            }
            .padding(.top, 10)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
