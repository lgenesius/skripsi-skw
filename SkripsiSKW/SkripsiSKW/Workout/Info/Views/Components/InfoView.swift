//
//  InfoView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 24/12/21.
//

import SwiftUI

struct InfoView: View {
    let info: Info
    
    var body: some View {
        VStack(alignment: .center) {
            Text(info.title)
                .modifier(TextModifier(
                    color: .white,
                    size: 34,
                    weight: .bold
                ))
            
            Spacer()
            
            Image(systemName: "chevron.top")
            
            Spacer()
            
            Text(info.description)
            
            Spacer()
            Spacer()
        }
        .padding()
    }
}
