//
//  PhotoPicker.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 06/01/22.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var data: Data
    var completion: ((Bool) -> Void)
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let photoPickerViewController = PHPickerViewController(configuration: configuration)
        photoPickerViewController.delegate = context.coordinator
        return photoPickerViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.data = Data()
            
            if !results.isEmpty {
                for result in results {
                    if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] item, error in
                            if let error = error {
                                print("Can't load image \(error.localizedDescription)")
                                self?.parent.completion(false)
                            } else if let image = item as? UIImage {
                                DispatchQueue.main.async {
                                    if let mediaData = image.jpegData(compressionQuality: 1) {
                                        self?.parent.data = mediaData
                                        self?.parent.completion(true)
                                    }
                                }
                            }
                        }
                    } else {
                        self.parent.completion(false)
                    }
                }
            } else {
                self.parent.completion(false)
            }
            
            self.parent.isPresented = false
        }
        
        private func runCompletionInMainThread(status: Bool) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.completion(status)
            }
        }
    }
}
