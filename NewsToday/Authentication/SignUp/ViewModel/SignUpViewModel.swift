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
    
    func createUser(name: String, email: String, password: String, repeatPassword: String) {
        isLoading = true
        Task {
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                try await authResult.user.sendEmailVerification()
                firestoreManager.saveUserData(userId: authResult.user.uid, name: name, email: email)
            } catch {
                print("Ошибка при регистрации: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}
