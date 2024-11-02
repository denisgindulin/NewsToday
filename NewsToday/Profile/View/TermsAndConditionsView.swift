//
//  TermsAndConditionsView.swift
//  NewsToday
//
//  Created by Kate Kashko on 23.10.2024.
//

import SwiftUI

struct TermsAndConditionsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var localizationService: LocalizationService
    
    var body: some View {
        ScrollView {
            Text(Resources.Text.termsAndConditionsText.localized(localizationService.language))
                .interFont(type: .regular, size: 16)
                .foregroundColor(.greyPrimary)
                .padding()
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(.greyLeftArrow)
                }
            }
            ToolbarItem(placement: .principal) {
                Text(Resources.Text.termsAndConditions.localized(localizationService.language))
                    .interFont(size: 24)
                    .foregroundColor(Color("BlackPrimary"))
            }
        }
    }
}

#Preview {
    TermsAndConditionsView()
}
