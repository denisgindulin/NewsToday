//
//  NewsCardView.swift
//  NewsToday
//
//  Created by Руслан on 23.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShareText: Identifiable {
    let id = UUID()
    let text: String
}

struct NewsCardView: View {
    @EnvironmentObject var localizationService: LocalizationService
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State var shareText: ShareText?
    
    var article: Article
    
    var body: some View {
        
        GeometryReader { geo in
            VStack(spacing: 0) {
                ZStack(alignment: .top) {
                    
                    if article.imageURL != nil {
                        WebImage(url: URL(string: article.imageURL ?? ""))
                            .resizable()
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: geo.size.height / 2.4, alignment: .center)
                            .opacity(0.5)
                    } else {
                        Image("EmptyImage")
                            .resizable()
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: geo.size.height / 2.4, alignment: .center)
                            .opacity(0.5)
                    }
                    
                    textOnImageHeader
                }
                .background(Color.black)
                
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Text(Resources.Text.results.localized(localizationService.language))
                                .interFont(type: .bold)
                                .foregroundStyle(.blackPrimary)
                                .padding(.bottom, 8)
                                .padding(.top, 24)
                            
                            Spacer()
                        }
                        
                        Text(article.description ?? "")
                            .font(.system(size: 16, weight: .light))
                    }
                    .foregroundStyle(.greyDarker)
                    .padding(.horizontal, 20)
                }
            }
            .sheet(item: $shareText) { shareText in
                ActivityView(text: shareText.text)
            }
        }
    }
}

extension NewsCardView {
    
    var textOnImageHeader: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            HStack {
                Button(action: { dismiss() },
                       label:  { Image("whiteLeftArrow") })
                
                Spacer()
    
                Button(action: {
                    if authViewModel.bookmarks.contains(where: { $0.id == article.id }) {
                        authViewModel.deleteBookmark(articleId: article.id)
                    } else {
                        authViewModel.addBookmark(article: article)
                    }
                }, label:  { Image(systemName: authViewModel.bookmarks.contains(where: { $0.id == article.id }) ? "bookmark.fill" : "bookmark") })
            }
            
            HStack {
                Spacer()
                
                Button(action: { shareText = ShareText(text: article.link ?? "")},
                       label:  { Image(systemName: "arrowshape.turn.up.right")})
            }
            
            articleText
            
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
        .foregroundColor(.white)
    }
    
    var articleText: some View {
        
        Group {
            Text(article.category?.first ?? "")
                .textCase(.uppercase)
                .font(.system(size: 12, weight: .bold))
                .padding(.horizontal, 16)
                .padding([.top, .bottom], 8)
                .background(Color.purplePrimary)
                .cornerRadius(16)
            
            Text(article.title ?? "")
                .font(.system(size: 20, weight: .bold))
            
            VStack(alignment: .leading, spacing: 0){
                Text(article.creator?.first ?? Resources.Text.unknownAuthor.localized(localizationService.language))
                    .font(.system(size: 16, weight: .bold))
                
                Text(Resources.Text.author.localized(localizationService.language))
                    .font(.system(size: 16, weight: .light))
            }
        }
    }
}
