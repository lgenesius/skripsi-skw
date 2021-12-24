//
//  InfoTabView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 24/12/21.
//

import SwiftUI

struct InfoTabView: View {
    @Binding var currentIndex: Int
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(0..<3) { index in
                
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}
