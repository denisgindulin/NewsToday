//
//  CategoryItems.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 28.10.2024.
//

import SwiftUI

struct CategoryItems: View {
    @EnvironmentObject var localizationService: LocalizationService
    @ObservedObject var viewModel: CategoriesViewModel
    @Binding var selectedCategories: Set<Category>
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 140), spacing: 16)]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                Button {
                    toggleSelection(for: category)
                    viewModel.saveFavoriteCategory(Array(selectedCategories))
                } label: {
                    HStack {
                        Text(emojiForCategory(category) + Resources.Text.localeCategories(category: category).localized(localizationService.language))
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
        if let index = selectedCategories.firstIndex(of: category) {
            selectedCategories.remove(at: index)
        } else {
            selectedCategories.insert(category)
        }
    }
}

extension CategoryItems {
    func emojiForCategory(_ category: Category) -> String {
        switch category {
        case .crime:
            return "👹"
        case .business:
            return "💰"
        case .domestic:
            return "🏠"
        case .education:
            return "📚"
        case .entertainment:
            return "🎭"
        case .environment:
            return "🌍"
        case .food:
            return "🍗"
        case .health:
            return "🏥"
        case .lifestyle:
            return "👟"
        case .other:
            return "❓"
        case .politics:
            return "⚖️"
        case .science:
            return "🔬"
        case .sports:
            return "⚽️"
        case .technology:
            return "💻"
        case .top:
            return "🏆"
        case .world:
            return "🌐"
        }
    }
}
