//
//  NewsView.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import SwiftUI

struct NewsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = NewsViewModel()
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
                    viewModel.loadCategory(category: newCategory)
                }
                
                // Поле поиска
                HStack {
                    TextField("Поиск новостей", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        if !searchText.isEmpty {
                            viewModel.searchNews(query: searchText)
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
                .padding(.horizontal)
                
                // Список новостей
                if viewModel.isLoading {
                    ProgressView("Загрузка...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Ошибка: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.articles) { article in
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
                Button("Sign Out") {
                    authViewModel.signOut()
                }
            }
            .navigationTitle("Новости")
            .onAppear {
                viewModel.loadCategory(category: selectedCategory)
            }
        }
    }
}

#Preview {
    NewsView()
}
