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
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            self?.isLoading = false
            guard error == nil else {
                print(error!.localizedDescription)
                self?.registrationError = error!.localizedDescription
                return
            }
            
            if let userId = result?.user.uid {
                result?.user.sendEmailVerification()
                self?.saveUserData(userId: userId, name: name, email: email)
            }
        }
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
