//
//  OnboardingCard.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 29.10.2024.
//

import SwiftUI

struct OnboardingCard: View {
    let imageName: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(self.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                               
                Text(self.imageName)
                    .font(.largeTitle)
                    .foregroundStyle(.red)
                    .padding(32)
                    .background(.white)
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    OnboardingCard(imageName: "one")
}
