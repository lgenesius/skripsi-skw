//
//  CameraAuthorizationManager.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 05/01/22.
//

import Foundation
import AVFoundation

enum CameraAuthorizationStatus {
    case granted
    case notRequested
    case unauthorized
}

final class CameraAuthorizationManager {
    static func requestCameraAuthorization(completion: @escaping (CameraAuthorizationStatus) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                guard granted else {
                    completion(.unauthorized)
                    return
                }
                completion(.granted)
            }
        }
    }
    
    static func getCameraAuthorizationStatus() -> CameraAuthorizationStatus {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .notDetermined:
            return .notRequested
        case .authorized:
            return .granted
        default:
            return .unauthorized
        }
    }
}
