//
//  TextModifier.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 20/12/21.
//

import SwiftUI

struct TextModifier: ViewModifier {
    var color: Color
    var size: CGFloat
    var weight: Font.Weight
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(Font.system(size: size, weight: weight, design: .default))
    }
}
