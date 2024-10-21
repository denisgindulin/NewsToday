//
//  NewsViewModel.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    let networkManager = NetworkManager()
    
    func loadTopHeadlines(category: Categories) {
        Task {
            await fetchArticles(endpoint: .latest(category: category))
        }
    }
    
    func searchNews(query: String) {
        Task {
            await fetchArticles(endpoint: .search(request: query))
        }
    }
    
    func fetchArticles(endpoint: Endpoint) async {
        isLoading = true
        errorMessage = nil
        do {
            let response = try await networkManager.fetchNews(endpoint: endpoint)
            self.articles = response
        } catch {
            print("Ошибка при получении новостей: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
