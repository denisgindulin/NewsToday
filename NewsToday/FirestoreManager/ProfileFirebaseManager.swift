//
//  ProfileFirebaseManager.swift
//  NewsToday
//
//  Created by Kate Kashko on 31.10.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

final class ProfileFirebaseManager {
    func uploadAvatar(imageData: Data) {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        StorageManager.shared.uploadImage(data: imageData, userId: userId) { result in
            switch result {
            case .success(let url):
                self.setUserAvatar(url: url.absoluteString)
            case .failure(let error):
                print("Upload error: \(error.localizedDescription)")
            }
        }
    }
    
    func setUserAvatar(url: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .setData(["avatarUrl": url], merge: true)
    }
    
    func fetchAvatar(userId: String, completion: @escaping (Result<Data, Error>) -> Void) {
        StorageManager.shared.downloadImage(userId: userId, completion: completion)
    }
}
