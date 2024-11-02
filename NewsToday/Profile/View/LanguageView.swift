//
//  LanguageView.swift
//  NewsToday
//
//  Created by Kate Kashko on 21.10.2024.
//



import SwiftUI

struct LanguageView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var localizationService: LocalizationService

    var body: some View {
        VStack(spacing: 16) {
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
        .padding(.top, 20)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(.greyLeftArrow)
                }
            }
            ToolbarItem(placement: .principal) {
                Text(Resources.Text.lang.localized(localizationService.language))
                    .interFont(size: 24)
                    .foregroundColor(Color("BlackPrimary"))
            }
        }
        Spacer()
    }
}
