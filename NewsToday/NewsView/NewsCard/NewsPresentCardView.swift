//
//  NewsPresentCardView.swift
//  NewsToday
//
//  Created by Руслан on 23.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsPresentCardView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var viewModel: NewsViewModel
    @State private var isFullScreen = false
    var article: Article
    
    var action: () -> ()
    
    var body: some View {
        Button {
            isFullScreen = true
        } label: {
            ZStack {
                if article.imageURL != nil {
                    WebImage(url: URL(string: article.imageURL ?? ""))
                        .resizable()
                        .opacity(0.7)
                } else {
                    Image("EmptyImage")
                        .resizable()
                        .opacity(0.7)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Button {
                            if authViewModel.bookmarks.contains(where: { $0.id == article.id }) {
                                viewModel.deleteBookmark(articleId: article.id)
                            } else {
                                viewModel.addBookmark(article: article)
                            }
                        } label: {
                            Image(systemName: authViewModel.bookmarks.contains(where: { $0.id == article.id }) ? "bookmark.fill" : "bookmark")
                                .foregroundColor(.white)
                        }
                    }
                    Spacer ()
                    
                    Text(article.category?.first ?? "")
                        .textCase(.uppercase)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                    
                    Text(article.title ?? "")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    
                }
                .multilineTextAlignment(.leading)
                .padding(.all, 24)
            }
            .background(Color.black)
            .frame(width: 256, height: 256)
            .cornerRadius(12)
        }
        .fullScreenCover(isPresented: $isFullScreen) {
            NewsCardView(fromBookmark: false, article: article)
        }
    }
}
