//
//  CustomTapBarView.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 22.10.2024.
//

import SwiftUI

enum Tab: Int {
    case home = 0
    case categories = 1
    case bookmark = 2
    case profile = 3
}

struct CustomTabBarView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            Button(action: { selectedTab = .home   }) { //switch to HomeView
                Image(systemName: "house")
                    .foregroundStyle(selectedTab != .home ? .gray : .green)
            }
            
            Button(action: { selectedTab = .categories }) { //switch to CategoriesView
                Image(systemName: "square.grid.2x2")
                    .foregroundStyle(selectedTab != .categories ? .gray : .green)
            }
            
            Button(action: { selectedTab = .bookmark }) { //switch to BookmarksView
                Image(systemName: "bookmark")
                    .foregroundStyle(selectedTab != .bookmark ? .gray : .green)
            }
            
            Button(action: { selectedTab = .profile }) { //switch to ProfileView
                Image(systemName: "person")
                    .foregroundStyle(selectedTab != .profile ? .gray : .green)
            }
            
            /*
            Button{
                // switch to BookmarkView
                selectedTab = .bookmark
            } label: {
                Image(selectedTab != .bookmark ? "bell" : "bellRed")
            }
            */
        }
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.categories))
}
