//
//  DailyChallengesView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 20/12/21.
//

import SwiftUI

struct DailyChallengesView: View {
    @State private var isDropDown = true
    
    var body: some View {
        VStack {
            HStack {
                Text("Daily Challenges")
                    .modifier(TextModifier(color: .white, size: 24, weight: .medium))
                Spacer()
                Button {
                    withAnimation {
                        isDropDown.toggle()
                    }
                } label: {
                    Image(systemName: isDropDown ? "chevron.down": "chevron.up")
                        .foregroundColor(.notYoCheese)
                        .frame(width: 20, height: 20)
                }
            }
            
            
            if isDropDown {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 15) {
                        ForEach(0..<6) { _ in
                            RoundedRectangle(cornerRadius: 13)
                                .frame(width: 321, height: 187)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

struct DailyChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        DailyChallengesView()
    }
}
