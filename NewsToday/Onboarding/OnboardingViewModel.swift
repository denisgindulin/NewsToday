//
//  OnboardingViewModel.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 30.10.2024.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
//    @AppStorage("isOnboardingShown") var isOnboardingShown = false
    
    @Published var isOnboardingShown: Bool

    init() {
        self.isOnboardingShown = UserDefaults.standard.bool(forKey: "isOnboardingShown")
    }
    
    func finishedOnboarding() {
        isOnboardingShown = true
        UserDefaults.standard.set(true, forKey: "isOnboardingShown")
    }
}
