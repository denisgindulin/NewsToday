//
//  FirestoreManager.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 24.10.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class FirestoreManager: ObservableObject {
    @Published var bookmarks: [Article] = []
    @Published var avatarUrl: String?
    
    func getUserData(userId: String) async throws -> UserData {
        let document = try await Firestore.firestore()
            .collection("users")
            .document(userId)
            .getDocument()
        
        guard let data = document.data() else {
            throw FirestoreError.documentNotFound
        }
        
        guard let name = data["name"] as? String else {
            throw FirestoreError.fieldNotFound(fieldName: "name")
        }
        
        guard let email = data["email"] as? String else {
            throw FirestoreError.fieldNotFound(fieldName: "email")
        }
        
        return UserData(id: userId,
                        name: name,
                        email: email)
    }
    
    func getUserCategories(userId: String) async throws -> [Category] {
        
        let document = try await Firestore.firestore()
            .collection("users")
            .document(userId)
            .getDocument()
        
        guard let data = document.data() else {
            throw FirestoreError.documentNotFound
        }
        
        guard let favoriteCategoriesRawValue = data["favoriteCategories"] as? [String] else {
            throw FirestoreError.fieldNotFound(fieldName: "favoriteCategories")
        }
        return favoriteCategoriesRawValue.compactMap { Category(rawValue: $0) }
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
    
    func saveFavoriteCategory(categories: [Category]) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let categoriesRawValues = categories.map { $0.rawValue }
        
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .setData([
                "favoriteCategories": categoriesRawValues
            ], merge: true) { error in
                if let error = error {
                    print("Error saving favorite categories: \(error.localizedDescription)")
                } else {
                    print("Favorite categories saved successfully")
                }
            }
    }
    
    func addBookmark(for article: Article) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let bookmark = Article(
            id: article.id,
            title: article.title,
            link: article.link,
            keywords: article.keywords,
            creator: article.category,
            description: article.description,
            pubDate: article.pubDate,
            imageURL: article.imageURL,
            country: article.country,
            category: article.category,
            duplicate: article.duplicate
        )
        
        do {
            try Firestore.firestore()
                .collection("users")
                .document(userId)
                .collection("bookmarks")
                .document(bookmark.id)
                .setData(from: bookmark)
            print("Save was successful")
        } catch {
            print("Error to save bookmark: \(error.localizedDescription)")
        }
    }
    
    func loadAvatarUrl(userId: String) {
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .addSnapshotListener { [weak self] snapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                self?.avatarUrl = snapshot?.data()?["avatarUrl"] as? String
            }
    }
    
    func fetchBookmark(userId: String) {
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .collection("bookmarks")
            .addSnapshotListener { [weak self] snapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                self?.bookmarks = snapshot?.documents.compactMap { document in
                    return try? document.data(as: Article.self)
                } ?? []
            }
    }
    
    func fetchBookmarks(userId: String) async throws -> [Article] {
        let bookmarksCollection = Firestore.firestore()
            .collection("users")
            .document(userId)
            .collection("bookmarks")
        
        do {
            let document = try await bookmarksCollection.getDocuments()
            let articles = try document.documents.map { document -> Article in
                return try document.data(as: Article.self)
            }
            print(articles.count)
            return articles
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func deleteBookmark(articleId: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .collection("bookmarks")
            .document(articleId)
            .delete { error in
                if let error = error {
                    print("Error when deleting document: \(error.localizedDescription)")
                } else {
                    print("The document was successfully deleted")
                }
            }
    }
}
