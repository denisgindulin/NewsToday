//
//  ProfileViewModel.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 22.10.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ProfileViewModel: ObservableObject {
    @Published var avatarImageData: Data?
    private let profileFirebaseManager = ProfileFirebaseManager()

    func uploadProfileImage(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        profileFirebaseManager.uploadAvatar(imageData: imageData)
    }

    func fetchProfileImage() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not authenticated")
            return
        }
        
        profileFirebaseManager.fetchAvatar(userId: userId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print("Image data fetched successfully")
                    self.avatarImageData = data // Store the downloaded image data
                case .failure(let error):
                    print("Error fetching avatar image: \(error.localizedDescription)")
                }
            }
        }
    }
    func signOut(authViewModel: AuthViewModel) {
        Task {
            await MainActor.run {
                authViewModel.signOut()
            }
        }
    }
}




