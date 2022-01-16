//
//  SignInView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 11/12/21.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var signInVM = SignInViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Group {
                    Image("Logo").resizable()
                                           .aspectRatio(contentMode: .fit)
                                           .frame(width: 130, height: 130)
                                           .cornerRadius(10)
                    
                    FormField(value: $signInVM.email, placeholder: "Enter your email...")
                        .padding(.top, 104)
                    
                    if !signInVM.emailErrorMessage.isEmpty {
                        ErrorText(errorMessage: signInVM.emailErrorMessage)
                    }
                    
                    FormField(value: $signInVM.password, placeholder: "Enter your password...", isSecure: true)
                        .padding(.top, 15)
                    
                    if !signInVM.passwordErrorMessage.isEmpty {
                        ErrorText(errorMessage: signInVM.passwordErrorMessage)
                    }
                    
                    RoundedButton(title: "Sign In") {
                        signInVM.signIn()
                    }
                    .padding(.top, 30)
                    
                    HStack {
                        Text("Don't have an Account?")
                            .font(Font.system(size: 14))
                            .foregroundColor(.white)
                        
                        NavigationLink {
                           SignUpView(signUpVM: SignUpViewModel())
                        } label: {
                            Text("Register Here")
                                .font(Font.system(size: 14, weight: .bold, design: .default))
                                .foregroundColor(.white)
                        }
                    }
                }
                Spacer()
                Spacer()
            }
            
            LoadingCard(isLoading: signInVM.isLoading, message: "Signing In...")
        }
        .navigationBarHidden(true)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
