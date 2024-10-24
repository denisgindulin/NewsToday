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
    func getUserData() async throws -> UserData {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw FirestoreError.userNotAuthenticated
        }
        
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
        
        return UserData(id: userId, name: name, email: email)
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
}
