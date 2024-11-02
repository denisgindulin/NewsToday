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
                            HStack {
                                WebImage(url: URL(string: bookmark.imageURL ?? ""))
                                    .resizable()
                                    .cornerRadius(12)
                                    .frame(width: 96, height: 96)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(bookmark.category?.first ?? "")
                                        .textCase(.uppercase)
                                        .interFont(type: .regular, size: 14)
                                        .foregroundColor(.gray)
                                    
                                    Text(bookmark.title ?? "")
                                        .interFont()
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(3)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteBookmark)
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .padding(.top, 20)
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
}

#Preview {
    FilledBookmarks()
        .environmentObject(AuthViewModel())
        .environmentObject(LocalizationService())
}
