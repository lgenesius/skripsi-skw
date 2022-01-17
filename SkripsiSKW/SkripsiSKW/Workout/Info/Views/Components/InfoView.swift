//
//  InfoView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 24/12/21.
//

import SwiftUI

struct InfoView: View {
    @Binding var isInfoPresent: Bool
    let info: Info
    var isLastInfo = false
    
    @State private var isBoxChecked = false
    
    var body: some View {
        VStack(alignment: .center) {
            Text(info.title)
                .modifier(TextModifier(
                    color: .white,
                    size: 34,
                    weight: .bold
                ))
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Image(info.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer()
            
            Text(info.description)
                .multilineTextAlignment(.center)
            
            Spacer()
            Spacer()
            
            if isLastInfo {
                HStack(spacing: 5) {
                    Image(systemName: isBoxChecked ? "checkmark.square.fill": "square")
                        .foregroundColor(isBoxChecked ? Color(UIColor.systemBlue): Color.white)
                    Text("Don't show this again")
                }
                .padding(.bottom, 5)
                .onTapGesture {
                    isBoxChecked.toggle()
                }
                
                RoundedButton(title: "Start") {
                    if isBoxChecked {
                        info.completion?(true)
                    }
                    
                    withAnimation {
                        isInfoPresent = false
                    }
                }
            }
        }
        .padding()
    }
}
