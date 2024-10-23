//
//  SignInViewModel.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 23.10.2024.
//

import Foundation
import FirebaseAuth

class SignInViewModel: ObservableObject {
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var signInError: String?
    @Published var isLoading: Bool = false
    
    func signIn(email: String, password: String) {
        signInError = nil
        
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
        
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            self?.isLoading = false
            
            if let error {
                self?.signInError = error.localizedDescription
            } else {
               print("Verification was successful")
            }
        }
    }
}
