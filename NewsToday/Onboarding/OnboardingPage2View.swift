//
//  OnboardingPage2View.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 24.10.2024.
//

import SwiftUI

struct OnboardingPage2View: View {
    @AppStorage("isOnboardingShown") var isOnboardingShown = false
    
    @State private var onboardingPage3ViewIsOn = false
    @State private var rootViewIsOn = false
    
    var body: some View {
        VStack {
            Circle().frame(width: 300).foregroundStyle(.brown)
            Spacer() // заглушка для ВТОРОЙ картинки и инструкции онбординга
            
            
            HStack {
                Image(.smallIndicator)
                Image(.largeIndicator)
                Image(.smallIndicator)
            }
            NavigationLink(isActive: $onboardingPage3ViewIsOn) {
                OnboardingPage3View()
                    .navigationBarBackButtonHidden()
            } label: {
                NextButton(title: "Next", titleFontSize: 24) {
                    onboardingPage3ViewIsOn.toggle()
                }
            }
            
            NavigationLink(isActive: $rootViewIsOn) {
                RootView(selectedTab: .home)
                    .navigationBarBackButtonHidden()
            } label: {
                SkipButton() {
                    rootViewIsOn.toggle()
                    isOnboardingShown = true
                }
            }
        }
    }
}

#Preview {
    OnboardingPage2View()
}
