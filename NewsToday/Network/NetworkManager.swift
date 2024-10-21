//
//  NetworkManager.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import Foundation

enum Categories: String {
    case general
    case business
    case technology
    case entertainment
    case science
    case health
    case sports
}

enum Endpoint {
    case everything(request: String)
    case topHeadlines(category: String)
    
    var path: String {
        switch self {
        case .everything: return "/v2/everything"
        case .topHeadlines: return "/v2/top-headlines"
        }
    }
}

final class NetworkManager {
    private let apiKey = "e30d6cfafc85469eb6f14e2f35443c88"
    
    private func createQueryItems(_ endpoint: Endpoint, language: String) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "pageSize", value: "20"),
        ]
        
        switch endpoint {
        case .everything(request: let request):
            queryItems.append(URLQueryItem(name: "q", value: request))
        case .topHeadlines(category: let category):
            queryItems.append(URLQueryItem(name: "category", value: category))
        }
        
        return queryItems
    }
    
    func fetchNews(endpoint: Endpoint, language: String = "en") async throws -> [Article] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = endpoint.path
        components.queryItems = createQueryItems(endpoint, language: language)
        
        guard let url = components.url else { throw URLError(.badURL)}
        print("Запрос URL: \(url)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        print(json ?? "")
        
        do {
            let decoder = try JSONDecoder().decode(News.self, from: data)
            return decoder.articles
        } catch {
            throw error
        }
    }
}
