//
//  CategoriEmojiView.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 28.10.2024.
//

import SwiftUI

struct CategoryEmojiView: View {
    @EnvironmentObject var localizationService: LocalizationService
    let category: Category
    
    var body: some View {
        switch category {
        case .crime:
            Text(Resources.Text.crime.localized(localizationService.language))
        case .business:
            Text(Resources.Text.business.localized(localizationService.language))
        case .domestic:
            Text(Resources.Text.domestic.localized(localizationService.language))
        case .education:
            Text(Resources.Text.education.localized(localizationService.language))
        case .entertainment:
            Text(Resources.Text.entertainment.localized(localizationService.language))
        case .environment:
            Text(Resources.Text.environment.localized(localizationService.language))
        case .food:
            Text(Resources.Text.food.localized(localizationService.language))
        case .health:
            Text(Resources.Text.health.localized(localizationService.language))
        case .lifestyle:
            Text(Resources.Text.lifestyle.localized(localizationService.language))
        case .other:
            Text(Resources.Text.other.localized(localizationService.language))
        case .politics:
            Text(Resources.Text.politics.localized(localizationService.language))
        case .science:
            Text(Resources.Text.science.localized(localizationService.language))
        case .sports:
            Text(Resources.Text.sport.localized(localizationService.language))
        case .technology:
            Text(Resources.Text.technology.localized(localizationService.language))
        case .top:
            Text(Resources.Text.top.localized(localizationService.language))
        case .world:
            Text(Resources.Text.world.localized(localizationService.language))
        }
    }
}

#Preview {
    CategoryEmojiView(category: .business)
}
