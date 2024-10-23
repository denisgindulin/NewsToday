//
//  ErrorText.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 23.10.2024.
//

import SwiftUI

struct ErrorText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .interFont(type: .regular)
            .foregroundStyle(.red)
    }
}
