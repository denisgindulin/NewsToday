//
//  News.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import Foundation

struct News: Codable {
    let status: String
    let totalResults: Int
    let results: [Article]
}

struct Article: Codable, Identifiable {
    let id: String
    let title: String?
    let link: String?
    let keywords, creator: [String]?
    let description: String?
    let pubDate: String?
    let imageURL: String?
    let country, category: [String]
    let duplicate: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "article_id"
        case title, link, keywords, creator, description, pubDate, imageURL, country, category, duplicate
    }
}