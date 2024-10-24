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
    @Published var displayName: String = ""
    @Published var email: String = (Auth.auth().currentUser?.email ?? "no email")
    @Published var isLoggedOut: Bool = false  // Для контроля состояния выхода

    func getUserData() {
        guard let userId = Auth.auth().currentUser?.uid else {return}
            
            Firestore.firestore()
                .collection("users")
                .document(userId)
                .getDocument { snapshot, error in
                    guard error == nil else {
                        return
                    }
                    if let document = snapshot {
                        let name = document["name"] as? String
                        self.displayName = name ?? "No name"
                    }
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



