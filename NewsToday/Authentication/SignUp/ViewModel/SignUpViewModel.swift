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
    @Published var nameError: String?
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var repeatPasswordError: String?
    @Published var registrationError: String?
    @Published var isLoading: Bool = false
    
    private let firestoreManager = FirestoreManager()
    
    func createUser(name: String, email: String, password: String, repeatPassword: String) {
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            nameError = "Fill the Username"
            return
        }
        nameError = nil
        
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            emailError = "Fill the Email"
            return
        }
        emailError = nil
        
        guard !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            passwordError = "Fill the Password"
            return
        }
        passwordError = nil
        
        guard !repeatPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            repeatPasswordError = "Fill the Password"
            return
        }
        
        guard !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
                !repeatPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
                password == repeatPassword else {
            repeatPasswordError = "Passwords don't match"
            return
        }
        
        repeatPasswordError = nil
        registrationError = nil
        
        isLoading = true
        Task {
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                try await authResult.user.sendEmailVerification()
                print("Подтверждение электронной почты отправлено.")
                firestoreManager.saveUserData(userId: authResult.user.uid, name: name, email: email)
            } catch {
                registrationError = error.localizedDescription
                print("Ошибка при регистрации: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}
