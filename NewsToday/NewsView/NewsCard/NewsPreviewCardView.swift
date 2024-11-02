//
//  NewsPreviewCardView.swift
//  NewsToday
//
//  Created by Руслан on 24.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsPreviewCardView: View {
    @EnvironmentObject var viewModel: NewsViewModel
    @State private var isFullScreen = false
    @Environment(\.dismiss) var dismiss
    
    var articles: [Article]
    var sourceScreen: Bool = false
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            
            if !sourceScreen {
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.black)
                    })
                    
                    Spacer()
                }
                .padding(.bottom, 20)
            }
            
            ForEach(articles) { article in
                ZStack {
                    Button {
                        isFullScreen = true
                    } label: {
                        HStack {
                            WebImage(url: URL(string: article.imageURL ?? ""))
                                .resizable()
                                .cornerRadius(12)
                                .frame(width: 96, height: 96)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(article.category?.first ?? "")
                                    .textCase(.uppercase)
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.gray)
                                
                                Text(article.title ?? "")
                                    .font(.system(size: 16, weight: .semibold))
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(3)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .fullScreenCover(isPresented: $isFullScreen) { 
                        NewsCardView(article: article)
                    }
                }
                .padding(.bottom, 8)
            }
        }
        .padding(.horizontal, 20)
    }
}
