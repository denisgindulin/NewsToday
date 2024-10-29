//
//  RootView.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 22.10.2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var localizationService: LocalizationService
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var selectedTab: Tab = .home
    
    var body: some View {
        if authViewModel.user != nil {
            
            switch selectedTab {
            case .home:
                NewsView() // заглушка для экрана HomeView
            case .categories:
                CategoriesView(title: Resources.Text.categoriesTitle.localized(localizationService.language),
                               subtitle: Resources.Text.categoriesText.localized(localizationService.language),
                               showButton: true)
            case .bookmark:
                //            BookmarksView() // здесь указать на Экран с избранными новостями
                Circle().frame(width: 200).foregroundStyle(.green)
                Spacer() // заглушка для экрана BookmarksView
            case .profile:
                ProfileView()
            }
            CustomTabBarView(selectedTab: $selectedTab)
        } else {
            SignInView()
        }
        
    }
}

#Preview {
    RootView()
}
