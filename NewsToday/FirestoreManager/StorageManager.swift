//
//  StorageManager.swift
//  NewsToday
//
//  Created by Kate Kashko on 30.10.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

final class StorageManager {
    static let shared = StorageManager()

    private init() {}
    
    func uploadImage(data: Data, userId: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let ref = Storage.storage().reference().child("\(userId)/avatar.jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        ref.putData(data, metadata: metadata) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            ref.downloadURL { url, error in
                if let url = url {
                    completion(.success(url))
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func downloadImage(userId: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let ref = Storage.storage().reference().child("\(userId)/avatar.jpg")
        print("Attempting to download image from path: \(userId)/avatar.jpg")

        ref.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if let data = data {
                print("Image data successfully downloaded for user \(userId)")
                completion(.success(data))
            } else if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
