//
//  GeometryGetter.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 21/12/21.
//

import SwiftUI

struct GeometryGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        GeometryReader { geo -> Path in
            DispatchQueue.main.async {
                self.rect = geo.frame(in: .global)
            }
            return Path()
        }
    }
}
