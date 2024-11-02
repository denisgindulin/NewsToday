//
//  NewsViewModel.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import Foundation
import Combine

@MainActor
class NewsViewModel: ObservableObject {
    
    private let networkManager = NetworkManager()
    private let firestoreManager = FirestoreManager()
    
    @Published var articles: [Article] = []
    @Published var recomendedarticles: [Article] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var searchText: String = ""
    @Published var selectedCategory: Category?
    @Published var loading: Bool = false
    @Published var language: String = "en"
    
    private var cancellables = [AnyCancellable]()
    
    init(
        errorMessage: String? = nil,
        searchText: String? = nil)
    {
        self.errorMessage = errorMessage
        
        $searchText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.loading = false
                case .failure(let _):
                    self.loading = true
                }
            }, receiveValue: { [weak self] text in
                if text != "" {
                    self?.loading = true
                    self?.searchNews(query: text)
                    self?.selectedCategory = nil
                }
            }).store(in: &cancellables)
    }
    
     func loadLatestNews() {
        Task {
            await fetchArticles(endpoint: .latest)
        }
    }
    
    func firstLoadRecomended(_ recomended: [Category]) {
        recomendedarticles = []
        for index in recomended {
            loadRecomendedCategory(category: index)
        }
    }
    
    private func loadRecomendedCategory(category: Category) {
        Task {
            await fetchArticles(endpoint: .category(category: category), recomended: true)
        }
    }
    
    func loadCategory(category: Category) {
        Task {
            await fetchArticles(endpoint: .category(category: category))
        }
    }
    
    private func searchNews(query: String) {
        Task {
            await fetchArticles(endpoint: .search(request: query))
        }
    }
    
    func fetchArticles(endpoint: Endpoint, recomended: Bool = false) async {
        isLoading = true
        errorMessage = nil
        do {
            let response = try await networkManager.fetchNews(endpoint: endpoint, language: language)
            if !recomended {
                self.articles = response
            } else {
                recomendedarticles.append(contentsOf: response)
            }
            print("Fetched articles count: \(self.articles.count)")
        } catch {
            print("Ошибка при получении новостей: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func addBookmark(article: Article) {
        firestoreManager.addBookmark(for: article)
    }
    
    func deleteBookmark(articleId: String) {
        firestoreManager.deleteBookmark(articleId: articleId)
    }
}
