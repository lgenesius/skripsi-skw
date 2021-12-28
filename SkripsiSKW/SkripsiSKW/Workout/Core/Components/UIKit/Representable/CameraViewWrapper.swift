//
//  CameraViewWrapper.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 28/12/21.
//

import Foundation
import SwiftUI

struct CameraViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let cvc = CameraViewController()
        return cvc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
