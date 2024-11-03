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
        NavigationView {
            VStack(alignment: .leading) {
                HeaderTitle(title: Resources.Text.bookmarksTitle.localized(localizationService.language),
                            subtitle: Resources.Text.bookmarksText.localized(localizationService.language))
                
                List {
                    ForEach(authViewModel.bookmarks) { bookmark in
                        NavigationLink {
                            NewsCardView(article: bookmark)
                                .navigationBarBackButtonHidden()
                        } label: {
                            NewsPreviewCardView(articles: bookmark)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: deleteBookmark)
                    .onMove(perform: move)
                }
                .padding(.top, 25)
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
