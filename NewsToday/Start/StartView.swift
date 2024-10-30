//
//  StartView.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 23.10.2024.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var localizationService: LocalizationService
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var onboardingViewsIsOn = false
    private let textHorizontalOffsetValue = UIScreen.main.bounds.width/10
    private let textVerticalOffsetValue = -(UIScreen.main.bounds.width/5)
    private let additionalVerticalOffsetValue = UIScreen.main.bounds.width/20
    private let titleFontSize: CGFloat = 60
    
    var body: some View {
        ZStack {
            Color(.purpleDarker)
                .ignoresSafeArea()
            VStack {
                Text("News")
                    .offset(x: -textHorizontalOffsetValue,
                            y: textVerticalOffsetValue + additionalVerticalOffsetValue)
                Text("ToDay")
                    .offset(x: textHorizontalOffsetValue,
                            y: textVerticalOffsetValue)
            }
            .font(.custom(AdaminaFont.regular.rawValue, size: titleFontSize))
            .foregroundStyle(.greyLight)
            .shadow(radius: 2, y: 4)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.onboardingViewsIsOn = true
            }
        }
        .fullScreenCover(isPresented: $onboardingViewsIsOn) { OnboardingView()
                .environmentObject(authViewModel)
                .environmentObject(localizationService)
        }
    }
}

#Preview {
    StartView()
}
