//
//  SignInViewModel.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 23.10.2024.
//

import Foundation
import FirebaseAuth

class SignInViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    
    func signIn(email: String, password: String) {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            self?.isLoading = false
            
            if error == nil {
                print("Verification was successful")
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}
