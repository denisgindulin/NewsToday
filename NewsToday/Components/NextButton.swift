//
//  NextButton.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 24.10.2024.
//

import SwiftUI

struct NextButton: View {
    let title: String
    let titleFontSize: CGFloat
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .padding()
            .frame(width: UIScreen.main.bounds.width - 40)
            .font(.custom(InterFont.semiBold.rawValue, size: titleFontSize))
            .background(.purplePrimary)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    NextButton(title: "Next", titleFontSize: 24, action: {})
}
