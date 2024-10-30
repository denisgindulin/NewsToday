//
//  News.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let results: [Article]
}

struct Article: Hashable, Codable, Identifiable {
    let id: String
    let title: String?
    let link: String?
    let keywords, creator: [String]?
    let description: String?
    let pubDate: String?
    let imageURL: String?
    let country, category: [String]?
    let duplicate: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "article_id"
        case imageURL = "image_url"
        case title, link, keywords, creator, description, pubDate, country, category, duplicate
    }
}
