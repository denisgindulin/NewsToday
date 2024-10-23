//
//  RootView.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 22.10.2024.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Tab = .home

    var body: some View {
        
        switch selectedTab {
        case .home:
//            HomeView() // здесь указать на Главный экран
            NewsView() // заглушка для экрана CategoriesView
        case .categories:
//            CategoriesView() // здесь указать на Экран выбора категорий новостей
            Circle().frame(width: 250).foregroundStyle(.red)
            Spacer() // заглушка для экрана CategoriesView
        case .bookmark:
//            BookmarksView() // здесь указать на Экран с избранными новостями
            Circle().frame(width: 200).foregroundStyle(.green)
            Spacer() // заглушка для экрана BookmarksView
        case .profile:
            ProfileView()
        }
        
        CustomTabBarView(selectedTab: $selectedTab)
    }
}

#Preview {
    RootView()
}
