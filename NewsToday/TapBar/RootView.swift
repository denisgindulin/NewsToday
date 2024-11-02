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
            VStack {
                switch selectedTab {
                case .home:
                    NewsView() // заглушка для экрана HomeView
                case .categories:
                    CategoriesView(
                        title: Resources.Text.categoriesTitle.localized(localizationService.language),
                        subtitle: Resources.Text.categoriesText.localized(localizationService.language),
                        showButton: false
                    )
                case .bookmark:
                    BookmarksView()
                case .profile:
                    ProfileView()
                }
            }
            .overlay(
                CustomTabBarView(selectedTab: $selectedTab)
                    .ignoresSafeArea(.keyboard),
                alignment: .bottom
            )
            .ignoresSafeArea(edges: .bottom)
        } else {
            SignInView()
        }
    }
}
