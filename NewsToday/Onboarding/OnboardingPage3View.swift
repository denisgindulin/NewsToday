//
//  OnboardingPage3View.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 24.10.2024.
//

import SwiftUI

struct OnboardingPage3View: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @AppStorage("isOnboardingShown") var isOnboardingShown = false
    
    @State private var rootViewIsOn = false
    
    var body: some View {
        VStack {
            Circle().frame(width: 200).foregroundStyle(.purple)
            Spacer() // заглушка для ТРЕТЬЕЙ картинки и инструкции онбординга
            
            
            HStack {
                Image(.smallIndicator)
                Image(.smallIndicator)
                Image(.largeIndicator)
            }
            NavigationLink(isActive: $rootViewIsOn) {
                RootView(selectedTab: .home)
                    .navigationBarBackButtonHidden()
            } label: {
                NextButton(title: "Get Started", titleFontSize: 24) {
                    rootViewIsOn.toggle()
                    isOnboardingShown = true
                }
            }
            
            Rectangle()
                .opacity(0)
                .frame(height: 60)
        }
    }
}

#Preview {
    OnboardingPage3View()
}
