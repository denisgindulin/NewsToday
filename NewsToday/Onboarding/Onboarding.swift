//
//  Onboarding.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 29.10.2024.
//

import Foundation
import SwiftUI

struct Onboarding: Identifiable {
    var id = UUID()
    let image: String
    let title: String
    let description: String
    
    static let items = [
        Onboarding(
            image: "homeScreen",
            title: "All in One Place",
            description: "be the first to know"
        ),
        Onboarding(
            image: "articleScreen",
            title: "Choose an Article",
            description: "read or add to bookmarks"
        ),
        Onboarding(
            image: "bookmarksScreen",
            title: "Bookmarks",
            description: "all your bookmarks are here"
        ),
        Onboarding(
            image: "profileScreen",
            title: "Sign in to the App",
            description: "to personalize the news"
        ),
        Onboarding(
            image: "languageScreen",
            title: "Choose a Language",
            description: "english or russian"
        ),
        Onboarding(
            image: "favoritesScreen",
            title: "Choose News Topics",
            description: "from many categories"
        ),
        Onboarding(
            image: "selectedFavoritesScreen",
            title: "Select Your Favorites",
            description: "get personalized news"
        ),
    ]
}

