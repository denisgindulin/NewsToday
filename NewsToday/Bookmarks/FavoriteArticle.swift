//
//  FavoriteArticle.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 31.10.2024.
//

import Foundation

struct FavoriteArticle: Identifiable, NewsItemProtocol {
    let id: String
    let title: String?
    let link: String?
    let keywords, creator: [String]?
    let description: String?
    let pubDate: String?
    let imageURL: String?
    let category: [String]?
}
