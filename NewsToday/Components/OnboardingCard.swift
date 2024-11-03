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
                Color(.purpleLighter)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(color: .greyPrimary, radius: 5, x: 0, y: 2)

                Image(self.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.95)
            }
        }
    }
}

#Preview {
    OnboardingCard(imageName: "homeScreen")
}
