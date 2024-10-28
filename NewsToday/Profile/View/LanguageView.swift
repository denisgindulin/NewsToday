//
//  LanguageView.swift
//  NewsToday
//
//  Created by Kate Kashko on 21.10.2024.
//



import SwiftUI

struct LanguageView: View {
    @EnvironmentObject var localizationService: LocalizationService

    var body: some View {
        VStack {
            CustomButtonProfile(
                text: Resources.Text.english.localized(localizationService.language),
                textColor: localizationService.language == .en ? .white : Color("GreyDarker"),
                backgroundColor: localizationService.language == .en ? Color("PurplePrimary") : Color("GreyLighter"),
                icon: localizationService.language == .en ? "checkmark" : ""
            ) {
                localizationService.language = .en
            }

            CustomButtonProfile(
                text: Resources.Text.russian.localized(localizationService.language),
                textColor: localizationService.language == .ru ? .white : Color("GreyDarker"),
                backgroundColor: localizationService.language == .ru ? Color("PurplePrimary") : Color("GreyLighter"),
                icon: localizationService.language == .ru ? "checkmark" : ""
            ) {
                localizationService.language = .ru
            }
        }
        .padding(.top, 24)
        .navigationTitle(Resources.Text.lang.localized(localizationService.language))
        Spacer()
    }
}
