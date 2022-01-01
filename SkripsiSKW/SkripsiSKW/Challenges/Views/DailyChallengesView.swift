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
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 15) {
                        ForEach(0..<6) { _ in
                            DailyChallengeCard()
//                            RoundedRectangle(cornerRadius: 13)
//                                .fill(Color.midnightExpress)
//                                .frame(width: Screen.width-75, height: 187) // 75 come from 40 padding horizontal, 15 spacing, and 20 to make the next rectangle appear
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
