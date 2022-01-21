//
//  TextEditorField.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 23/12/21.
//

import SwiftUI

struct TextEditorField: View {
    @Binding var value: String
    var placeholder: String
    
    init(value: Binding<String>, placeholder: String) {
        UITextView.appearance().backgroundColor = .clear
        self._value = value
        self.placeholder = placeholder
    }
    
    var body: some View {
//        if #available(iOS 15.0, *) {
//           
//            TextEditor(text: $value)
//                .autocapitalization(.none)
//                .disableAutocorrection(true)
//                .font(Font.system(size: 17))
//                .frame(height: 140)
//                .padding(16)
//                .cornerRadius(5)
//                .background(Color.blueDepths)
//                .overlay {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 5)
//                            .stroke(Color.blueDepths, lineWidth: 1.0)
//                        
//                        VStack {
//                            if value.isEmpty {
//                                HStack {
//                                    Text(placeholder)
//                                        .font(Font.system(size: 17))
//                                        .foregroundColor(.gray)
//                                    Spacer()
//                                }
//                            }
//                            Spacer()
//                        }
//                        .padding(24)
//                    }
//                    .allowsHitTesting(false)
//                }
//                .padding(.horizontal)
//        } else {
            // Fallback on earlier versions
            TextEditor(text: $value)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .font(Font.system(size: 17))
                .frame(height: 140)
                .padding(16)
                .cornerRadius(4)
                .background(Color.blueDepths)
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.blueDepths, lineWidth: 1.0)
                        
                        VStack {
                            if value.isEmpty {
                                HStack {
                                    Text(placeholder)
                                        .font(Font.system(size: 17))
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                        .padding(24)
                    }
                    .allowsHitTesting(false)
                )
                .padding(.horizontal)
//        }
    }
}

struct TextEditorField_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorField(value: .constant(""), placeholder: "Describe your Competition")
        
    }
}
