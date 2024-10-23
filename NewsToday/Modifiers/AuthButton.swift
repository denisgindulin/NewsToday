//
//  AuthButton.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 22.10.2024.
//

import SwiftUI

struct AuthButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(.purplePrimary)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
