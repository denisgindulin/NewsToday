//
//  NewsPreviewCardView.swift
//  NewsToday
//
//  Created by Руслан on 24.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsPreviewCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: NewsViewModel
    @State private var isFullScreen = false
    
    let fromBookmark: Bool
    var articles: Article
    var sourceScreen: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
                ZStack {
                    Button {
                        isFullScreen = true
                    } label: {
                        NewsMiniCard(
                            imageURL: articles.imageURL,
                            titleNews: articles.title,
                            category: articles.category?.first
                        )
                    }
                }
                .padding(.bottom, 8)
        }
        .padding(.horizontal, 20)
        .fullScreenCover(isPresented: $isFullScreen) {
            NewsCardView(fromBookmark: fromBookmark, article: articles)
        }
    }
}


struct NewsMiniCard: View {
    
    var imageURL: String?
    var titleNews: String?
    var category: String?
    
    var body: some View {
        HStack {
            if imageURL != nil {
                WebImage(url: URL(string: imageURL ?? ""))
                    .resizable()
                    .cornerRadius(12)
                    .frame(width: 96, height: 96)
            } else {
                Image("EmptyImage")
                    .resizable()
                    .cornerRadius(12)
                    .frame(width: 96, height: 96)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(category ?? "")
                    .textCase(.uppercase)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
                
                Text(titleNews ?? "")
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .foregroundColor(.black)
            }
        }
    }
}
