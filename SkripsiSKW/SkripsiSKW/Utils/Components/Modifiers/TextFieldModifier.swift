//
//  TextFieldModifier.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    let fontSize: CGFloat
    let backgroundColor: Color
    let textColor: Color
    let weight: Font.Weight

    func body(content: Content) -> some View {
        content
            .font(Font.system(size: fontSize, weight: weight))
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(backgroundColor))
            .foregroundColor(textColor)
            .padding()
    }
}
