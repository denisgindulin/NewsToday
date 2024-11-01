//
//  OnboardingViewModel.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 30.10.2024.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @AppStorage("isOnboardingShown") var isOnboardingShown = false
    
    func finishedOnboarding() {
        isOnboardingShown = true
    }
}
