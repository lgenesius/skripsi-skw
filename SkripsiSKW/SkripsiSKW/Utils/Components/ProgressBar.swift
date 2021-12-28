//
//  ProgressBar.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 24/12/21.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Float
    let backgroundColor: Color
    let progressBarColor: Color
    let height: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(backgroundColor)
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(progressBarColor)
                        .animation(.linear)
            }.cornerRadius(45.0)
        }.frame(height: height)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: .constant(0.5), backgroundColor: Color.oldSilver, progressBarColor: Color.notYoCheese,
                    height: CGFloat(20))
    }
}
