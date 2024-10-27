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
    
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var searchText: String = ""
    @Published var selectedCategory: Categories? = .crime
    @Published var loading: Bool = false
    
    private var cancellables = [AnyCancellable]()
    
    init(
        errorMessage: String? = nil,
        searchText: String? = nil)
    {
        self.errorMessage = errorMessage
        
        $searchText
            .throttle(for: .seconds(4), scheduler: RunLoop.main, latest: true)
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
        
        loadCategory(category: selectedCategory ?? Categories.top)
    }
    
    
    let networkManager = NetworkManager()
    
    init() {
        loadCategory(category: .top)
    }
    
    func loadCategory(category: Categories) {
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
            print("Fetched articles count: \(self.articles.count)")
        } catch {
            print("Ошибка при получении новостей: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
