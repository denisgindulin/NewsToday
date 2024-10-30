//
//  CategoryItems.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 28.10.2024.
//

import SwiftUI

struct CategoryItems: View {
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
