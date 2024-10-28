//
//  CustomButton.swift
//  NewsToday
//
//  Created by Kate Kashko on 23.10.2024.
//

import SwiftUI

struct CustomButtonProfile: View {
    var text: LocalizedStringKey
    var textColor: Color
    var backgroundColor: Color
    var icon: String
    var action: (() -> Void)? = nil  // Optional action for buttons without NavigationLink

    var body: some View {
        Button(action: {
            action?()
        }) {
            HStack {
                Text(text)
                    .interFont()
                    .foregroundColor(textColor)
                Spacer()
                if !icon.isEmpty {
                    Image(systemName: icon)
                        .foregroundColor(textColor)
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 40, height: 56)
            .background(backgroundColor)
            .cornerRadius(12)
        }
        .disabled(action == nil)  // Disable button if no action is provided
    }
}


