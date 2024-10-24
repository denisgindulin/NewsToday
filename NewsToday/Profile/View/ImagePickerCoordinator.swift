//
//  ImagePickerCoordinator.swift
//  NewsToday
//
//  Created by Kate Kashko on 23.10.2024.
//

import SwiftUI
import UIKit

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool

    init(image: Binding<UIImage?>, isPresented: Binding<Bool>) {
        _image = image
        _isPresented = isPresented
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            image = uiImage
        }
        isPresented = false
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isPresented = false
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool

    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(image: $image, isPresented: $isPresented)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

