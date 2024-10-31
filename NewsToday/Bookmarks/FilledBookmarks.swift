//
//  FilledBookmarks.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 31.10.2024.
//

import SwiftUI

struct FilledBookmarks: View {
    @EnvironmentObject var viewModel: NewsViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HeaderTitle(title: "Bookmarks",
                        subtitle: "Saved articles to the library")
            
            ScrollView {
                VStack(alignment: .leading) {
                    NewsPreviewCardView(viewModel: viewModel, articles: authViewModel.bookmarks, sourceScreen: true)
                }
                .padding(.vertical, 32)
            }
        }
    }
}
