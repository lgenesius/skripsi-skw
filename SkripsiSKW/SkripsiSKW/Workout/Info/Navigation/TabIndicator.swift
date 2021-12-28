//
//  TabIndicator.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 24/12/21.
//

import SwiftUI

struct TabIndicator: View {
    var count: Int
    @Binding var current: Int
    
    var body: some View {
        HStack {
            ForEach(0..<count) { index in
                ZStack {
                    Capsule()
                        .fill(current == index ? .white: .gray)
                }
                .frame(width: 7, height: 7)
            }
        }
    }
}
