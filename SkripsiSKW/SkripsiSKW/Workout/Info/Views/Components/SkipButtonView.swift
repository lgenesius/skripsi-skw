//
//  SkipButtonView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 24/12/21.
//

import SwiftUI

struct SkipButtonView: View {
    @Binding var currentIndex: Int
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                currentIndex = 2
            } label: {
                Text("Skip")
                    .foregroundColor(.white)
            }
        }
        .opacity(currentIndex != 2 ? 1: 0)
        .allowsHitTesting(currentIndex != 2 ? true: false)
        .padding()
    }
}