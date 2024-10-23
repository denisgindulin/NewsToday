//
//  AuthViewModel.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 23.10.2024.
//

import Foundation
import FirebaseAuth
import FirebaseAuthCombineSwift

class AuthViewModel: ObservableObject {
    @Published var user: User?
    
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        listenToAuthState()
    }
    
    private func listenToAuthState() {
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            self?.user = user
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    deinit {
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
