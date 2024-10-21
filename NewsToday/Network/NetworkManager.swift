//
//  NetworkManager.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import Foundation

enum Categories: String, CaseIterable {
    case crime
    case business
    case domestic
    case education
    case entertainment
    case environment
    case food
    case health
    case lifestyle
    case other
    case politics
    case science
    case sports
    case technology
    case top
    case world
}

enum Endpoint {
    case search(request: String)
    case latest(category: Categories)
}

final class NetworkManager {
    private let apiKey = "pub_568854a7fb181713bae23f68d4a833dcaf42a"
    
    private func createQueryItems(_ endpoint: Endpoint, language: String) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "language", value: language),
        ]
        
        switch endpoint {
        case .search(let query):
            queryItems.append(URLQueryItem(name: "q", value: query))
        case .latest(let category):
            queryItems.append(URLQueryItem(name: "category", value: category.rawValue))
        }
        
        return queryItems.compactMap { $0.value != nil ? $0 : nil }
    }
    
    func fetchNews(endpoint: Endpoint, language: String = "ru") async throws -> [Article] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsdata.io"
        components.path = "/api/1/news"
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
            let decoder = try JSONDecoder().decode(NewsResponse.self, from: data)
            return decoder.results
        } catch {
            throw error
        }
    }
}
