//
//  FilledBookmarks.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 31.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct FilledBookmarks: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var localizationService: LocalizationService
    
    @State private var selectedBookmark: Article? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderTitle(title: Resources.Text.bookmarksTitle.localized(localizationService.language),
                        subtitle: Resources.Text.bookmarksText.localized(localizationService.language))
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(authViewModel.bookmarks, id: \.self) { bookmark in
                        NewsPreviewCardView(
                            fromBookmark: true,
                            articles: bookmark,
                            sourceScreen: true
                        )
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 88)
                .listStyle(.plain)
            }
        }
    }
    
    func deleteBookmark(at offsets: IndexSet) {
        // Получаем закладки для удаления
        let bookmarksToDelete = offsets.map { authViewModel.bookmarks[$0] }
        
        // Удаляем закладки из локального массива
        authViewModel.bookmarks.remove(atOffsets: offsets)
        
        // Удаляем закладки из Firestore
        for bookmark in bookmarksToDelete {
            authViewModel.deleteBookmark(articleId: bookmark.id)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        authViewModel.bookmarks.move(fromOffsets: source, toOffset: destination)
    }
}

#Preview {
    FilledBookmarks()
        .environmentObject(AuthViewModel())
        .environmentObject(LocalizationService())
}
