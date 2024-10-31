//
//  CategoriesView.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 22.10.2024.
//

import SwiftUI

struct HeaderTitle: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .interFont(size: 24)
                .foregroundStyle(.blackPrimary)
            Text(subtitle)
                .interFont(type: .regular)
                .foregroundStyle(.greyPrimary)
        }
        
        .padding(.horizontal, 20)
    }
}

struct CategoriesView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = CategoriesViewModel()
    
    let title: String
    let subtitle: String
    let showButton: Bool
    
    @State private var selectedCategories: Set<Category> = []
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderTitle(title: title, subtitle: subtitle)
            
            ScrollView {
                VStack(alignment: .center, spacing: 16) {
                    CategoryItems(viewModel: viewModel, selectedCategories: $authViewModel.selectedCategories)
                    if showButton {
                        Button {
                            //
                        } label: {
                            Text("Next")
                                .authButton()
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 32)
            }
        }
        
    }
}

#Preview {
    CategoriesView(title: "Select your favorite topics",
                   subtitle: "Select some of your favorite topics to let us suggest better news for you.",
                   showButton: true)
}
