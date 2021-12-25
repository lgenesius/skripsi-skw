//
//  InfoTabView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 24/12/21.
//

import SwiftUI

struct InfoTabView: View {
    @Binding var currentIndex: Int
    let infos: [Info]
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(0..<3) { index in
                if index == 2 {
                    InfoView(info: infos[index], isLastInfo: true)
                } else {
                    InfoView(info: infos[index])
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}
