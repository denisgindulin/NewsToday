//
//  SkipButton.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 24.10.2024.
//

import SwiftUI

struct SkipButton: View {
    let action: () -> Void
    
    var body: some View {
        Button("Skip", action: action)
            .font(.custom(InterFont.semiBold.rawValue, size: 20))
            .foregroundStyle(.purplePrimary)
            .padding(.bottom, 24)
            .padding(.top, 8)
    }
}

#Preview {
    SkipButton(action: {})
}
