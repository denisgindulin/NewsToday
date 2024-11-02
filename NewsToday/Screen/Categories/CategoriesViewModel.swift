//
//  CategoriesViewModel.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 22.10.2024.
//

import Foundation
import FirebaseAuth

class CategoriesViewModel: ObservableObject {
//    @Published var selectedCategories: Set<Category> = []
    let firestoreManager = FirestoreManager()
    
//    init() {
//        loadFavoriteCategories()
//    }
    
//    func loadFavoriteCategories() {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("No authenticated user found.")
//            return
//        }
//        
//        Task {
//            guard let categories = try? await firestoreManager.getUserCategories(userId: userId) else { return }
//            
//            DispatchQueue.main.async {
//                self.selectedCategories = Set(categories)
//            }
//        }
//    }
    
    func saveFavoriteCategory(_ categories: [Category]) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No authenticated user found.")
            return
        }
        
        firestoreManager.saveFavoriteCategory(userId: userId, categories: categories)
    }
}
