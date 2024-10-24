//
//  OnboardingPage1View.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 24.10.2024.
//

import SwiftUI

struct OnboardingPage1View: View {
    @AppStorage("isOnboardingShown") var isOnboardingShown = false
    
    @State private var onboardingPage2ViewIsOn = false
    @State private var rootViewIsOn = false
    
    var body: some View {
        NavigationView() {
            
            VStack {
                Circle().frame(width: 300).foregroundStyle(.orange)
                Spacer() // заглушка для ПЕРВОЙ картинки и инструкции онбординга
                
                
                HStack {
                    Image(.largeIndicator)
                    Image(.smallIndicator)
                    Image(.smallIndicator)
                }
                NavigationLink(isActive: $onboardingPage2ViewIsOn) {
                    OnboardingPage2View()
                        .navigationBarBackButtonHidden()
                } label: {
                    NextButton(title: "Next", titleFontSize: 24) {
                        onboardingPage2ViewIsOn.toggle()
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
}

#Preview {
    OnboardingPage1View()
}

/*
 struct OnboardingPage1View: View {
     @AppStorage("onboardingIsShow") var onboardingIsShow = false
     @ObservedObject var appManager: RecipesManager
     @State private var onboardingPage2ViewIsOn = false
     @State private var homeViewIsOn = false
     
     var body: some View {
         ZStack(alignment: .bottom) {
             OnboardingBackgroundView(backgroundImage: .onboardingOneBackground)
             DarkeningGradientView()
             VStack {
                 OnboardingTextView(
                     whiteText: "Recipes from\nall ",
                     orangeText: "over the\nWorld"
                 )
                 IndicatorsView(activeIndicatorIndex: 0)
                 NavigationLink(isActive: $onboardingPage2ViewIsOn) {
                     OnboardingPage2View(appManager: appManager)
                         .navigationBarBackButtonHidden()
                 } label: {
                     ContinueButtonView(title: "Continue") {
                         onboardingPage2ViewIsOn.toggle()
                     }
                 }
                 NavigationLink(isActive: $homeViewIsOn) {
                     HomeView(appManager: appManager)
                         .navigationBarBackButtonHidden()
                 } label: {
                     SkipButtonView() {
                         homeViewIsOn.toggle()
                         onboardingIsShow = true
                     }
                 }
             }
         }
     }
 }

 */
