//
//  FontModifier.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import SwiftUI

struct InterFontModifier: ViewModifier {
    let type: InterFont
    let size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom(type.rawValue, size: size))
    }
}
