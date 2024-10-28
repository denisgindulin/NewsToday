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
    
    @State private var selectedCategories: Set<Category> = [] 
//        didSet {
//            print("Selected categories changed: \(selectedCategories)")
//            viewModel.saveFavoriteCategory(Array(selectedCategories))
//        }
//    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .interFont(size: 24)
                        .foregroundStyle(.blackPrimary)
                    Text(subtitle)
                        .interFont(type: .regular)
                        .foregroundStyle(.greyPrimary)
                }
                VStack(alignment: .center, spacing: 16) {
                    CategoryItems(viewModel: viewModel, selectedCategories: $authViewModel.selectedCategories)
                    Button {
                        //
                    } label: {
                        Text("Next")
                            .authButton()
                    }

                }
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    CategoriesView(title: "Select your favorite topics",
                   subtitle: "Select some of your favorite topics to let us suggest better news for you.",
                   showButton: true)
}

struct CategoryItems: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel: CategoriesViewModel
    @Binding var selectedCategories: Set<Category>
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 160), spacing: 16)]
    
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                Button {
                    toggleSelection(for: category)
                    viewModel.saveFavoriteCategory(Array(selectedCategories))
                } label: {
                    HStack {
                        CategoryEmojiView(category: category)
                        Text(category.rawValue)
                    }
                    .padding(.vertical, 24)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(selectedCategories.contains(category) ? .white : .greyDarker)
                    .background(selectedCategories.contains(category) ? .purplePrimary : .greyLighter)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
    }
    
    private func toggleSelection(for category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}
