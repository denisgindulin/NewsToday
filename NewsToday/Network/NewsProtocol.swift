//
//  NewsProtocol.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 31.10.2024.
//

import Foundation

protocol NewsItemProtocol: Identifiable {
    var id: String { get }
    var title: String? { get }
    var description: String? { get }
    var creator: [String]? { get }
    var imageURL: String? { get }
    var category: [String]? { get }
    var link: String? { get }
}
