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
    // Выход из аккаунта
    func signOut(authViewModel: AuthViewModel) {
        Task {
            await MainActor.run {
                authViewModel.signOut()
            }
        }
    }
}



