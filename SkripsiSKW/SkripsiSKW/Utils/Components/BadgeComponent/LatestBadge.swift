//
//  LatestBadge.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 27/12/21.
//

import SwiftUI

struct LatestBadge: View {
    @ObservedObject var badgesViewModel : AllBadgeViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text("Latest Badges")
                .modifier(TextModifier(
                    color: .white,
                    size: 24,
                    weight: .medium
                ))
            
            HStack(spacing: 15) {
                ForEach(0..<3) { _ in
                    BadgeItem().onTapGesture {
                        badgesViewModel.showBadgeDetail.toggle()
                    }
                }
            }
        }
        .padding(.top, 20)
        .padding(.horizontal)
    }
}

