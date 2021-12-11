//
//  SignInView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 11/12/21.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    
    @State private var errorMessage: String = ""
    @State private var showingAlert = false
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Group {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.red)
                        .frame(width: 114, height: 114)
                    
                    VStack(spacing: 15) {
                        FormField(value: $email, placeholder: "Enter your email...")
                        
                        FormField(value: $password, placeholder: "Enter your password...", isSecure: true)
                        
                    }
                    .padding(.top, 104)
                    
                    RoundedButton(title: "Sign In") {
                        
                    }
                    .padding(.top, 30)
                    
                    HStack {
                        Text("Don't have an Account?")
                            .font(Font.system(size: 14))
                            .foregroundColor(.white)
                        
                        NavigationLink {
                            EmptyView()
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
