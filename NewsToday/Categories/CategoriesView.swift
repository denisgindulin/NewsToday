//
//  CategoriesView.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 22.10.2024.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = CategoriesViewModel()
    
    let title: String
    let subtitle: String
    let showButton: Bool
    let padding: CGFloat
    
    @State private var selectedCategories: Set<Category> = []
    @State private var text = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderTitle(title: title, subtitle: subtitle)
            
            ScrollView {
                VStack(alignment: .center, spacing: 16) {
                    CategoryItems(viewModel: viewModel, selectedCategories: $authViewModel.selectedCategories)
                    if showButton {
                        Button {
                            authViewModel.hasSelectedCategories = true
                        } label: {
                            Text("Next")
                                .authButton()
                        }
                    }
                    Rectangle()
                        .frame(height: 100)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.top, 32)
                .padding(.bottom, padding)
            }
        }
        
    }
}

#Preview {
    CategoriesView(title: "Select your favorite topics",
                   subtitle: "Select some of your favorite topics to let us suggest better news for you.",
                   showButton: true,
                   padding: 0)
}
