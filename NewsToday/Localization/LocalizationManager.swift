//
//  LocalizationManager.swift
//  NewsToday
//
//  Created by Kate Kashko on 28.10.2024.
//



import Combine
import SwiftUI

enum Language: String, CaseIterable, Codable, Identifiable {
    case ru = "ru"
    case en = "en"
    var id: String { self.rawValue }
}

final class LocalizationService: ObservableObject {
    public static let shared = LocalizationService()
    @Published var language: Language {
        didSet {
            saveLanguage(language)
        }
    }

    private init() {
        language = Language(rawValue: UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en") ?? .en
    }

    private func saveLanguage(_ language: Language) {
        UserDefaults.standard.setValue(language.rawValue, forKey: "selectedLanguage")
        UserDefaults.standard.set([language.rawValue], forKey: "AppleLanguages")
    }
}

extension String {
    func localized(_ language: Language) -> String {
        guard let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return self
        }
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
