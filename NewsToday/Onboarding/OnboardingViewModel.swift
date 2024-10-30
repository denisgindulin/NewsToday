//
//  OnboardingViewModel.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 30.10.2024.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    
    var onboardingItems: [OnboardingItem]
    var currentCardIndex: Int
//    var currentCardIndex = -(onboardingItems.count/2) // ряд карточек отцентрирован (HStack.frame(alignment:)) и, чтобы показать первую карточку, устанавливаю отрицательное значение индекса
    
    init() {
        onboardingItems = [
            OnboardingItem(
                image: "firstScreen",
                title: "First to know",
                description: "all"
            ),
            OnboardingItem(
                image: "two",
                title: "заголовок для two",
                description: "описание для two"
            ),
            OnboardingItem(
                image: "three",
                title: "заголовок для three",
                description: "описание для three"
            ),
            OnboardingItem(
                image: "four",
                title: "заголовок для four",
                description: "описание для four"
            ),
            OnboardingItem(
                image: "five",
                title: "заголовок для five",
                description: "описание для five"
            ),
            OnboardingItem(
                image: "six",
                title: "заголовок для six",
                description: "описание для six"
            ),
            OnboardingItem(
                image: "seven",
                title: "заголовок для seven",
                description: "описание для seven"
            ),
        ]
        currentCardIndex = -(onboardingItems.count/2)
        
    }
        
        
//        OnboardingItem(
//            image: "firstScreen",
//            title: "First to know",
//            description: "all"
//        ),
//        OnboardingItem(
//            image: "two",
//            title: "заголовок для two",
//            description: "описание для two"
//        ),
//        OnboardingItem(
//            image: "three",
//            title: "заголовок для three",
//            description: "описание для three"
//        ),
//        OnboardingItem(
//            image: "four",
//            title: "заголовок для four",
//            description: "описание для four"
//        ),
//        OnboardingItem(
//            image: "five",
//            title: "заголовок для five",
//            description: "описание для five"
//        ),
//        OnboardingItem(
//            image: "six",
//            title: "заголовок для six",
//            description: "описание для six"
//        ),
//        OnboardingItem(
//            image: "seven",
//            title: "заголовок для seven",
//            description: "описание для seven"
//        ),
//        ], currentCardIndex: Int = (onboardingItems.count/2)) {
//            self.onboardingItems = onboardingItems
//            self.currentCardIndex = currentCardIndex
//        }
}

