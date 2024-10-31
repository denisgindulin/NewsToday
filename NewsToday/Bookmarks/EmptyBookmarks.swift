//
//  EmptyBookmarks.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 31.10.2024.
//

import SwiftUI

struct EmptyBookmarks: View {
    @EnvironmentObject var localizationService: LocalizationService
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "book.closed")
                .padding()
                .foregroundStyle(.purplePrimary)
                .background(.purpleLighter)
                .clipShape(Circle())
            Text(Resources.Text.bookmarksNote.localized(localizationService.language))
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding(.horizontal, 60)
    }
}
