//
//  NewsView.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import SwiftUI

struct NewsView: View {
    @EnvironmentObject var localizationService: LocalizationService
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var viewModel: NewsViewModel
    
    @State private var isFullScreen = false
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    
                    headerTitle
                    
                    ScrollView(.vertical, showsIndicators: false ){
                        LazyVStack(alignment: .leading, spacing: 24) {
                            
                            AppTextField(textFieldText: $viewModel.searchText,
                                         placeholder: (Resources.Text.search.localized(localizationService.language)),
                                         imageName: "magnifyingglass")
                            .padding(.horizontal, 20)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(Category.allCases, id: \.self) { category in
                                        Button {
                                            viewModel.selectedCategory = category
                                            viewModel.loadCategory(category: category)
                                        } label: {
                                            Text(category.rawValue)
                                                .textCase(.uppercase)
                                                .font(.system(size: 12, weight: .semibold))
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 16)
                                                .padding([.top, .bottom], 8)
                                        }
                                        .background(viewModel.selectedCategory != category ? Color.gray : Color.purplePrimary)
                                        .cornerRadius(16)
                                    }
                                }
                                .padding(.leading, 20)
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(viewModel.articles, id: \.self) { news in
                                        NewsPresentCardView(article: news, action: {})
                                    }
                                }
                                .padding(.leading, 20)
                            }
                            
                            Spacer()
                            
                            LazyVStack(alignment: .leading, spacing: 0) {
                                
                                recomendTitles
                                
                                NewsPreviewCardView(fromBookmark: false, articles: viewModel.articles, sourceScreen: true)
                            }
                            .padding(.bottom, 16)
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $isFullScreen) {
                NewsPreviewCardView(fromBookmark: false, articles: viewModel.articles)
            }
        }.navigationTitle(Resources.Text.browseTitle.localized(localizationService.language))
    }
}


extension NewsView {
    
    var headerTitle: some View {
        Group {
            Text(Resources.Text.browseTitle.localized(localizationService.language))
                .font(.system(size: 24, weight: .semibold))
                .multilineTextAlignment(.leading)
                .padding(.bottom, 8)
                .padding(.top, 28)
            
            Text(Resources.Text.browseText.localized(localizationService.language))
                .multilineTextAlignment(.leading)
                .font(.system(size: 16, weight: .regular))
                .padding(.bottom, 32)
        }
        .padding(.leading, 20)
    }
    
    var recomendTitles: some View {
        HStack {
            
            Text(Resources.Text.recommended.localized(localizationService.language))
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
            
            Button {
                isFullScreen = true
            } label: {
                Text((Resources.Text.seeAll.localized(localizationService.language)))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
            }
            
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 24)
    }
}
