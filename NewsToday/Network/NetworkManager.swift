//
//  NetworkManager.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import Alamofire
import Foundation

enum Endpoint {
    case search(request: String)
    case category(category: Category)
    case latest
}

final class NetworkManager {
    private func createQueryItems(_ endpoint: Endpoint, language: String) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "apiKey", value: ApiKey.second),
            URLQueryItem(name: "language", value: language),
        ]
        
        switch endpoint {
        case .search(let query):
            queryItems.append(URLQueryItem(name: "q", value: query))
        case .category(let category):
            queryItems.append(URLQueryItem(name: "category", value: category.rawValue))
        case .latest:
            print("latest")
        }
        
        return queryItems.compactMap { $0.value != nil ? $0 : nil }
    }
    
    func fetchNews(endpoint: Endpoint, language: String = "en") async throws -> [Article] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsdata.io"
        components.path = "/api/1/latest"
        components.queryItems = createQueryItems(endpoint, language: language)
        
        guard let url = components.url else { throw URLError(.badURL)}
        print("Запрос URL: \(url)")
        
        let newsResponse = await AF.request(url)
            .validate(statusCode: 200..<300)
            .serializingDecodable(NewsResponse.self)
            .response
        
        if let data = newsResponse.data {
            if let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) {
                print(jsonData)
            }
        }
        
        switch newsResponse.result {
        case .success(let news):
            return news.results
        case .failure(let error):
            throw error
        }
    }
}
