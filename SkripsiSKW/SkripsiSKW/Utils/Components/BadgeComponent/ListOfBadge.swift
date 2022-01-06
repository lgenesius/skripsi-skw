//
//  ListOfBadge.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 27/12/21.
//

import SwiftUI

struct ListOfBadge: View {
    @ObservedObject var badgesViewModel : AllBadgeViewModel
    private let gridLayout = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    var body: some View {
        VStack(alignment: .leading) {
            Text("List of Badges")
                .modifier(TextModifier(
                    color: .white,
                    size: 24,
                    weight: .medium
                ))
            
            LazyVGrid(columns: gridLayout, spacing: 15) {
                ForEach(0..<9) { _ in
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
