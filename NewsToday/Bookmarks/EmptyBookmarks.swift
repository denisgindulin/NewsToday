//
//  EmptyBookmarks.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 31.10.2024.
//

import SwiftUI

struct EmptyBookmarks: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "book.closed")
                .padding()
                .foregroundStyle(.purplePrimary)
                .background(.purpleLighter)
                .clipShape(Circle())
            Text("You haven't saved any articles yet. Start reading and bookmarking them now")
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding(.horizontal, 60)
    }
}
