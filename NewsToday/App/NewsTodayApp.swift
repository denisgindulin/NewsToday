//
//  NewsTodayApp.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 20.10.2024.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct NewsTodayApp: App {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var newsLoader = NewsViewModel()
    @StateObject var onboardingViewModel = OnboardingViewModel()
    
    @StateObject private var localizationService = LocalizationService.shared
    
    
    @State private var onboardingViewsIsOn = UserDefaults.standard.bool(forKey: "onboardingViewsIsOn")
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if !onboardingViewModel.isOnboardingShown {
                StartView()
                    .environmentObject(authViewModel)
                    .environmentObject(newsLoader)
                    .environmentObject(localizationService)
                    .environmentObject(onboardingViewModel)
            } else {
                RootView()
                    .environmentObject(authViewModel)
                    .environmentObject(newsLoader)
                    .environmentObject(localizationService)
                    .environmentObject(onboardingViewModel)
            }
        }
    }
}
