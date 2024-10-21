//
//  ContentView.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 20.10.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NewsViewModel()
    @State private var selectedCategory: Categories = .general
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Выбор категории
                Picker("Категория", selection: $selectedCategory) {
                    ForEach([Categories.general, .business, .entertainment, .health, .science, .sports, .technology], id: \.self) { category in
                        Text(category.rawValue.capitalized).tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: selectedCategory) { newCategory in
                    viewModel.loadTopHeadlines(category: newCategory)
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
                .padding([.leading, .trailing])
                
                // Список новостей
                if viewModel.isLoading {
                    ProgressView("Загрузка...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Ошибка: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.articles, id: \.title) { article in
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
            .onAppear {
                viewModel.loadTopHeadlines(category: selectedCategory)
            }
        }
    }
}

#Preview {
    ContentView()
}
