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
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.red)
                        .frame(width: 114, height: 114)
                    
                    VStack(spacing: 15) {
                        FormField(value: $signInVM.email, placeholder: "Enter your email...")
                        
                        FormField(value: $signInVM.password, placeholder: "Enter your password...", isSecure: true)
                        
                    }
                    .padding(.top, 104)
                    
                    if !signInVM.errorMessage.isEmpty {
                        HStack {
                            Text(signInVM.errorMessage)
                                .font(Font.system(size: 12))
                                .foregroundColor(.red)
                            Spacer()
                        }
                        .padding(.horizontal)
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
        }
        .navigationBarHidden(true)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
