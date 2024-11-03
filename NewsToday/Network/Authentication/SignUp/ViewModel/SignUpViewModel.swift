//
//  SignUpViewModel.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 22.10.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignUpViewModel: ObservableObject {    
    @Published var isLoading: Bool = false
    
    private let firestoreManager = FirestoreManager()
    
    @MainActor
    func createUser(name: String, email: String, password: String, repeatPassword: String) async throws {
        isLoading = true
        
        Task {
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                firestoreManager.saveUserData(userId: authResult.user.uid, name: name, email: email)
                try await authResult.user.sendEmailVerification()
            } catch {
                print("Ошибка при регистрации: \(error.localizedDescription)")
                throw error
            }
            isLoading = false
        }
    }
}
