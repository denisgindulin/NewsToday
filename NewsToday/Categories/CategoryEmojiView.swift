//
//  CategoriEmojiView.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 28.10.2024.
//

import SwiftUI

struct CategoryEmojiView: View {
    let category: Category
    
    var body: some View {
        switch category {
        case .crime:
            Text("👹")
        case .business:
            Text("💰")
        case .domestic:
            Text("🏠")
        case .education:
            Text("📚")
        case .entertainment:
            Text("🎭")
        case .environment:
            Text("🌍")
        case .food:
            Text("🍗")
        case .health:
            Text("🏥")
        case .lifestyle:
            Text("👟")
        case .other:
            Text("❓")
        case .politics:
            Text("⚖️")
        case .science:
            Text("🔬")
        case .sports:
            Text("⚽️")
        case .technology:
            Text("💻")
        case .top:
            Text("🏆")
        case .world:
            Text("🌐")
        }
    }
}

#Preview {
    CategoryEmojiView(category: .business)
}
