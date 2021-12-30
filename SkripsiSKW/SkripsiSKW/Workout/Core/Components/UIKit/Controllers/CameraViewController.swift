//
//  CameraViewController.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 28/12/21.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    var delegate: AVCaptureVideoDataOutputSampleBufferDelegate?
    
    private var cameraSession: AVCaptureSession?
    private let cameraQueue = DispatchQueue(label: "CameraOutput", qos: .userInteractive)
    private var cameraView: CameraView { view as! CameraView }
    
    override func loadView() {
        view = CameraView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        do {
            if cameraSession == nil {
                try prepareAVSession()
                cameraView.previewLayer.session = cameraSession
                cameraView.previewLayer.videoGravity = .resizeAspectFill
            }
            cameraSession?.startRunning()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cameraSession?.stopRunning()
        super.viewWillDisappear(animated)
    }
    
    private func prepareAVSession() throws {
        let session = AVCaptureSession()
        session.beginConfiguration()
        session.sessionPreset = AVCaptureSession.Preset.high
        
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        guard let deviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
        guard session.canAddInput(deviceInput) else { return }
        session.addInput(deviceInput)
        
        let dataOutput = AVCaptureVideoDataOutput()
        if session.canAddOutput(dataOutput) {
            session.addOutput(dataOutput)
            dataOutput.setSampleBufferDelegate(delegate, queue: cameraQueue)
        } else {
            return
        }
        
        session.commitConfiguration()
        cameraSession = session
    }
    
    func updateVideoOrientation() {
        guard cameraView.previewLayer.connection != nil, cameraView.previewLayer.connection!.isVideoOrientationSupported else { return }
        let statusBarOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        let videoOrientation: AVCaptureVideoOrientation = statusBarOrientation?.videoOrientation ?? .portrait
        cameraView.previewLayer.frame = view.layer.bounds
        cameraView.previewLayer.connection?.videoOrientation = videoOrientation
        cameraView.previewLayer.removeAllAnimations()
    }
}

extension UIInterfaceOrientation {
    var videoOrientation: AVCaptureVideoOrientation? {
        switch self {
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeRight: return .landscapeRight
        case .landscapeLeft: return .landscapeLeft
        case .portrait: return .portrait
        default: return nil
        }
    }
}