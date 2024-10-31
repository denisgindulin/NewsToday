//
//  BookmarksView.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 22.10.2024.
//

import SwiftUI

struct BookmarksView: View {
    @State private var favoriteArticles: [FavoriteArticle] = [
        FavoriteArticle(
            id: UUID().uuidString,
            title: "A Simple Trick For Creating Color Palettes Quickly",
            link: nil,
            keywords: nil,
            creator: nil,
            description: nil,
            pubDate: nil,
            imageURL: "https://cdn.iz.ru/sites/default/files/styles/900x506/public/news-2024-10/20161209_gaf_u55_049.jpg?itok=qWpwiH8q",
            category: ["UI/UX Design"]),
        
        FavoriteArticle(
            id: UUID().uuidString,
            title: "Six steps to creating a color palette",
            link: nil,
            keywords: nil,
            creator: nil,
            description: nil,
            pubDate: nil,
            imageURL: "https://www.sports.kz/upload/2024-10/67228964556f6.jpg",
            category: ["Art"]),
        
        FavoriteArticle(
            id: UUID().uuidString,
            title: "Creating Color Palette from world around you",
            link: nil,
            keywords: nil,
            creator: nil,
            description: nil,
            pubDate: nil,
            imageURL: "https://mf.b37mrtl.ru/russian/images/2024.10/article/67228c0c02e8bd6eaf2dac5a.jpg",
            category: ["Colors"]),
        
        FavoriteArticle(
            id: UUID().uuidString,
            title: "A Simple Trick For Creating Color Palettes Quickly",
            link: nil,
            keywords: nil,
            creator: nil,
            description: nil,
            pubDate: nil,
            imageURL: "https://i.obozrevatel.com/news/2024/10/30/filestoragetemp1.jpg?size=1200x630",
            category: ["UI/UX Design"]),
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderTitle(title: "Bookmarks",
                        subtitle: "Saved articles to the library")
            
            ScrollView {
                VStack(alignment: .leading) {
                    NewsPreviewCardView(articles: favoriteArticles, sourceScreen: true)
//                    ForEach(favoriteArticles) { article in
//                        HStack {
//                            Text(article.title ?? "")
//                        }
//                    }
                }
//                .padding(.horizontal, 20)
                .padding(.vertical, 32)
            }
        }
    }
}

#Preview {
    BookmarksView()
}
