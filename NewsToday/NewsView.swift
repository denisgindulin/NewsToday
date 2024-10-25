//
//  NewsView.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import SwiftUI

struct NewsView: View {
    @EnvironmentObject var newsLoader: NewsViewModel
    
    @State private var selectedCategory: Categories = .top
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Выбор категории
                Picker("Категория", selection: $selectedCategory) {
                    ForEach(Categories.allCases, id: \.self) { category in
                        Text(category.rawValue.capitalized).tag(category)
                    }
                }
                .padding()
                .onChange(of: selectedCategory) { newCategory in
                    newsLoader.loadCategory(category: newCategory)
                }
                
                // Поле поиска
                HStack {
                    TextField("Поиск новостей", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        if !searchText.isEmpty {
                            newsLoader.searchNews(query: searchText)
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
                .padding(.horizontal)
                
                // Список новостей
                if newsLoader.isLoading {
                    ProgressView("Загрузка...")
                        .padding()
                } else if let errorMessage = newsLoader.errorMessage {
                    Text("Ошибка: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(newsLoader.articles) { article in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(article.title ?? "")
                                .font(.headline)
                            if let description = article.description {
                                Text(description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Новости")
        }
    }
}

#Preview {
    NewsView()
}
