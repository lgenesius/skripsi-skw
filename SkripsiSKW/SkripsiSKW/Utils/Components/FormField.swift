//
//  FormField.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 11/12/21.
//

import SwiftUI

struct FormField: View {
    @Binding var value: String
    var placeholder: String
    var isSecure = false
    
    var body: some View {
        if #available(iOS 15.0, *) {
            Group {
                if isSecure {
                    SecureField("", text: $value)
                } else {
                    TextField("", text: $value)
                }
            }
            .textInputAutocapitalization(.none)
            .disableAutocorrection(true)
            .font(Font.system(size: 17))
            .foregroundColor(.white)
            .padding(15)
            .background(Color.blueDepths)
            .cornerRadius(5)
            .overlay {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.blueDepths, lineWidth: 1.0)
                    
                    if value.isEmpty {
                        HStack {
                            Text(placeholder)
                                .font(Font.system(size: 17))
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding(.leading)
                    }
                }
                .allowsHitTesting(false)
            }
            .padding(.horizontal)
        } else {
            // Fallback on earlier versions
            Group {
                if isSecure {
                    SecureField(placeholder, text: $value)
                } else {
                    TextField(placeholder, text: $value)
                }
            }
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .font(Font.system(size: 17))
            .foregroundColor(.white)
            .padding(15)
            .background(Color.blueDepths)
            .cornerRadius(5)
            .overlay(
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.blueDepths, lineWidth: 1.0)
                    
                    if value.isEmpty {
                        HStack {
                            Text(placeholder)
                                .font(Font.system(size: 17))
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding(.leading)
                    }
                }
                .allowsHitTesting(false)
            )
            .padding(.horizontal)
        }
    }
}

struct FormField_Previews: PreviewProvider {
    static var previews: some View {
        FormField(value: .constant(""), placeholder: "Enter your name...")
    }
}