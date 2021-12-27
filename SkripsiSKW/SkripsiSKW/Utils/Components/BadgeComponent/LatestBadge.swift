//
//  LatestBadge.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 27/12/21.
//

import SwiftUI

struct LatestBadge: View {
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
                    RoundedRectangle(cornerRadius: 13)
                        .fill(Color.blueDepths)
                        .frame(maxWidth: .infinity, minHeight: 125)
                }
            }
        }
        .padding(.top, 20)
        .padding(.horizontal)
    }
}

struct LatestBadge_Previews: PreviewProvider {
    static var previews: some View {
        LatestBadge()
    }
}
