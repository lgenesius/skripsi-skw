//
//  ActivityIndicator.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 18/12/21.
//

import SwiftUI

struct UIActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .label
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
