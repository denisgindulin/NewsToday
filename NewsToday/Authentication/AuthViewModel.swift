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
    @Published var user: UserData?
    @Published var selectedCategories: Set<Category> = []
    
    private let firestoreManager = FirestoreManager()
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        listenToAuthState()
    }
    
    private func listenToAuthState() {
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if let user {
                self?.loadUserData(userId: user.uid)
                self?.loadFavoriteCategories(userId: user.uid)
            } else {
                self?.user = nil
            }
        }
    }
    
    func loadUserData(userId: String) {
        Task {
            guard let user = try? await firestoreManager.getUserData(userId: userId) else { return }
            DispatchQueue.main.async {
                self.user = user
            }
        }
    }
    
    func loadFavoriteCategories(userId: String) {
        Task {
            guard let categories = try? await firestoreManager.getUserCategories(userId: userId) else { return }
            
            DispatchQueue.main.async {
                self.selectedCategories = Set(categories)
            }
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
