//
//  CustomViewWrapper.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 28/12/21.
//

import SwiftUI

struct CustomViewWrapper <Content: View>: View {
    var color: Color
    var content: () -> Content
       
    init(@ViewBuilder content: @escaping () -> Content, color: Color) {
        self.content = content
        self.color = color
    }

    var body: some View {
        ZStack {
            color.ignoresSafeArea()
            content()
        }
    }
}
