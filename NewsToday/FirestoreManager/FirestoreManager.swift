//
//  FirestoreManager.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 24.10.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirestoreManager: ObservableObject {
    func getUserData(userId: String) async throws -> UserData {
        let document = try await Firestore.firestore()
            .collection("users")
            .document(userId)
            .getDocument()
        
        guard let data = document.data() else {
            throw FirestoreError.documentNotFound
        }
        
        guard let name = data["name"] as? String else {
            throw FirestoreError.fieldNotFound(fieldName: "name")
        }
        
        guard let email = data["email"] as? String else {
            throw FirestoreError.fieldNotFound(fieldName: "email")
        }
        
        
        return UserData(id: userId,
                        name: name,
                        email: email)
    }
    
    func getUserCategories(userId: String) async throws -> [Category] {
        
        let document = try await Firestore.firestore()
            .collection("users")
            .document(userId)
            .getDocument()
        
        guard let data = document.data() else {
            throw FirestoreError.documentNotFound
        }
        
        guard let favoriteCategoriesRawValue = data["favoriteCategories"] as? [String] else {
            throw FirestoreError.fieldNotFound(fieldName: "favoriteCategories")
        }
        return favoriteCategoriesRawValue.compactMap { Category(rawValue: $0) }
    }
    
    func saveUserData(userId: String, name: String, email: String) {
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .setData([
                "name": name,
                "email": email
            ])
    }
    
    func saveFavoriteCategory(userId: String, categories: [Category]) {
        let categoriesRawValues = categories.map { $0.rawValue }
        
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .setData([
                "favoriteCategories": categoriesRawValues
            ], merge: true) { error in
                if let error = error {
                    print("Error saving favorite categories: \(error.localizedDescription)")
                } else {
                    print("Favorite categories saved successfully")
                }
            }
    }
}
