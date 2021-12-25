//
//  InfoView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 24/12/21.
//

import SwiftUI

struct InfoView: View {
    let info: Info
    var isLastInfo = false
    
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
                .frame(width: 250, height: 250)
            
            Spacer()
            
            Text(info.description)
                .multilineTextAlignment(.center)
            
            Spacer()
            Spacer()
            
            if isLastInfo {
                Text("Don't show this again")
                RoundedButton(title: "Start") {
                    
                }
            }
        }
        .padding()
    }
}
