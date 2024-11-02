//
//  HeaderTitle.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 01.11.2024.
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
