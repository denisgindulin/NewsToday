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
            Spacer()

            Button(action: { selectedTab = .home /* switch to HomeView */}) {
                Image("Home")
//                    .foregroundColor(.blue)
                    .foregroundStyle(selectedTab != .home ? .greyLight : .purplePrimary)
            }
            
            Spacer()
            Spacer()

            Button(action: {selectedTab = .categories /* switch to CategoriesView */}) {
                Image("categoriesIcon")
                    .foregroundStyle(selectedTab != .categories ? .greyLight : .purplePrimary)
            }
            
            Spacer()
            Spacer()

            Button(action: { selectedTab = .bookmark /* switch to BookmarksView */}) {
                Image("bookmarkIcon")
                    .foregroundStyle(selectedTab != .bookmark ? .greyLight : .purplePrimary)
            }
            
            Spacer()
            Spacer()

            Button(action: { selectedTab = .profile /* switch to ProfileView */}) {
                Image("profileIcon")
                    .foregroundStyle(selectedTab != .profile ? .greyLight : .purplePrimary)
            }
            
            Spacer()

            
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
    CustomTabBarView(selectedTab: .constant(.home))
}
