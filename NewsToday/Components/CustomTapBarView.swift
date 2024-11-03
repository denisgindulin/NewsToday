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
        ZStack {
            Rectangle()
                .foregroundStyle(.clear)
                .frame(height: UIScreen.main.bounds.height / 9)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: Color(.greyDarker).opacity(0.5), radius: 0, x: 0, y: -1)
            
            HStack {
                Spacer()
                
                Button(action: { selectedTab = .home }) {
                    Image("Home")
                        .foregroundStyle(selectedTab != .home ? .greyLight : .purplePrimary)
                }
                
                Spacer()
                Spacer()
                
                Button(action: {selectedTab = .categories }) {
                    Image("categoriesIcon")
                        .foregroundStyle(selectedTab != .categories ? .greyLight : .purplePrimary)
                }
                
                Spacer()
                Spacer()
                
                Button(action: { selectedTab = .bookmark }) {
                    Image("bookmarkIcon")
                        .foregroundStyle(selectedTab != .bookmark ? .greyLight : .purplePrimary)
                }
                
                Spacer()
                Spacer()
                
                Button(action: { selectedTab = .profile }) {
                    Image("profileIcon")
                        .foregroundStyle(selectedTab != .profile ? .greyLight : .purplePrimary)
                }
                
                Spacer()
            }
            .padding(.bottom, 32)
        }
        .zIndex(2)
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.home))
}
