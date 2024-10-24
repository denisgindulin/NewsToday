//
//  ProfileViewModel.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 22.10.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    private let firestoreManager = FirestoreManager()
    @Published var user: UserData?
    @Published var isLoggedOut: Bool = false  // Для контроля состояния выхода
    
    func setUserData() async {
        let user = try? await firestoreManager.getUserData()
        DispatchQueue.main.async { [weak self] in
            self?.user = user
        }
    }

    // Выход из аккаунта
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isLoggedOut = true  // Пользователь вышел
        } catch let error as NSError {
            print("Error signing out: %@", error)
        }
    }
}



