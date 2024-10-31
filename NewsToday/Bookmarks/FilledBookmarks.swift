//
//  FilledBookmarks.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 31.10.2024.
//

import SwiftUI

struct FilledBookmarks: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var localizationService: LocalizationService
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderTitle(title: Resources.Text.bookmarksTitle.localized(localizationService.language),
                        subtitle: Resources.Text.bookmarksText.localized(localizationService.language))
            
            ScrollView {
                VStack(alignment: .leading) {
                    NewsPreviewCardView(fromBookmark: true, articles: authViewModel.bookmarks, sourceScreen: true)
                }
                .padding(.vertical, 32)
            }
        }
    }
}
