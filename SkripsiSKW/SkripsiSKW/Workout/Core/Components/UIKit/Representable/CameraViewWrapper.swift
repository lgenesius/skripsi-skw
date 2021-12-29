//
//  CameraViewWrapper.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 28/12/21.
//

import Foundation
import SwiftUI

struct CameraViewWrapper: UIViewControllerRepresentable {
    @State private var cameraVC = CameraViewController()
    func makeUIViewController(context: Context) -> some UIViewController {
        return cameraVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        cameraVC.updateVideoOrientation()
    }
}
