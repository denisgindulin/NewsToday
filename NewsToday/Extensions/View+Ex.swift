//
//  View+Ex.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import SwiftUI

extension View {
    func interFont(type: InterFont = .semiBold, size: CGFloat = 16) -> some View {
        modifier(InterFontModifier(type: type, size: 16))
    }
}
