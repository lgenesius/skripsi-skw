//
//  CameraView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 28/12/21.
//

import UIKit
import AVFoundation

final class CameraView: UIView {
    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
    
    var previewLayer: AVCaptureVideoPreviewLayer {
        layer as! AVCaptureVideoPreviewLayer
    }
}
