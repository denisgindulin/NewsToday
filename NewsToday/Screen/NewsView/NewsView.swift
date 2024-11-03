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
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isFullScreen = false
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    HeaderTitle(title: Resources.Text.browseTitle.localized(localizationService.language),
                                subtitle: Resources.Text.browseText.localized(localizationService.language))

                    ScrollView(.vertical, showsIndicators: false ){
                        VStack(spacing: 48) {
                            VStack(alignment: .leading, spacing: 24) {
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
                                                Text(Resources.Text.localeCategories(category: category).localized(localizationService.language))
                                                    .textCase(.uppercase)
                                                    .interFont(size: 12)
                                                    .foregroundStyle(viewModel.selectedCategory != category ? .greyPrimary : .white)
                                                    .padding(.horizontal, 16)
                                                    .padding([.top, .bottom], 8)
                                            }
                                            .background(viewModel.selectedCategory != category ? .greyLighter : .purplePrimary)
                                            .cornerRadius(16)
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        ForEach(viewModel.articles, id: \.self) { news in
                                            NewsPresentCardView(article: news, action: {})
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 24) {
                                recomendTitles
                                
                                ForEach(viewModel.recomendedarticles, id: \.self) { recomendArticle in
                                    NewsPreviewCardView(fromBookmark: false, articles: recomendArticle, sourceScreen: true)
                                }
                                
                                if viewModel.articles.isEmpty {
                                    ForEach(0..<10) { _ in
                                        EmptyNewsView()
                                    }
                                }
                            }
                        }
                        .padding(.top, 32)
                        .padding(.bottom, 98)
                    }
                }
            }
            .fullScreenCover(isPresented: $isFullScreen) {
                ScrollView {
                    ForEach(viewModel.articles, id: \.self) { articles in
                        NewsPreviewCardView(articles: articles)
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadLatestNews()
            viewModel.firstLoadRecomended(Array(authViewModel.selectedCategories))
        }
        .navigationTitle(Resources.Text.browseTitle.localized(localizationService.language))
    }
}


extension NewsView {
    
    var headerTitle: some View {
        Group {
            Text(Resources.Text.browseTitle.localized(localizationService.language))
                .interFont(size: 24)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 8)
                .padding(.top, 28)
            
            Text(Resources.Text.browseText.localized(localizationService.language))
                .multilineTextAlignment(.leading)
                .interFont(type: .regular)
        }
        .padding(.leading, 20)
    }
    
    var recomendTitles: some View {
        HStack {
            
            Text(Resources.Text.recommended.localized(localizationService.language))
                .interFont(size: 20)
                .foregroundColor(.black)
            
            Spacer()
            
            Button {
                isFullScreen = true
            } label: {
                Text((Resources.Text.seeAll.localized(localizationService.language)))
                    .interFont(type: .medium, size: 14)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
            }
            .disabled(!viewModel.articles.isEmpty)
        }
        .padding(.horizontal, 20)
    }
}
