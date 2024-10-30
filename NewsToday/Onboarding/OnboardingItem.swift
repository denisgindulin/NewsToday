//
//  OnboardingItem.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 29.10.2024.
//

import Foundation
import SwiftUI

struct OnboardingItem: Identifiable {
    var id = UUID()
    let image: String
    let title: String
    let description: String
    
    static let onboardingItems = [
             OnboardingItem(
                 image: "firstScreen",
                 title: "First to know",
                 description: "All news in one place, be the first to know last news"
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
}

