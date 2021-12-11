//
//  SignUpView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 11/12/21.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        ZStack {
            Color.sambucus
                .ignoresSafeArea()
            
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
                
                Spacer()
                
                signUpTextField
                
                signUpSecureField
                
                Spacer()
                
                RoundedButton(title: "Register") {
                    
                }
                
                Spacer()
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
                
                FormField(value: $firstName, placeholder: "Enter your first name...")
            }
            
            VStack(spacing: 5) {
                HStack {
                    Text("Last Name")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                
                FormField(value: $lastName, placeholder: "Enter your last name...")
            }
            .padding(.top, 10)
            
            VStack(spacing: 5) {
                HStack {
                    Text("Username")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                
                FormField(value: $username, placeholder: "Enter your username...")
            }
            .padding(.top, 10)
            
            VStack(spacing: 5) {
                HStack {
                    Text("Email")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                
                FormField(value: $email, placeholder: "Enter your email...")
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
                
                FormField(value: $password, placeholder: "Enter your password...", isSecure: true)
            }
            .padding(.top, 10)
            
            VStack(spacing: 5) {
                HStack {
                    Text("Re-type Password")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading)
                
                FormField(value: $confirmPassword, placeholder: "Re-enter your password...", isSecure: true)
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
