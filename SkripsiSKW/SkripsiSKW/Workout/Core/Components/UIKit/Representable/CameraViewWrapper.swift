//
//  CameraViewWrapper.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 28/12/21.
//

import Foundation
import SwiftUI

struct CameraViewWrapper: UIViewControllerRepresentable {
    var poseEstimator: PoseEstimator
    
    @State private var cameraVC = CameraViewController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        cameraVC.delegate = poseEstimator
        return cameraVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        cameraVC.updateVideoOrientation()
    }
}
