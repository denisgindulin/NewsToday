//
//  LanguageView.swift
//  NewsToday
//
//  Created by Kate Kashko on 21.10.2024.
//

import SwiftUI

struct LanguageView: View {
    @State private var selectedLanguage: String = "" 
    
    var body: some View {
        VStack {
            // English Button
            CustomButtonProfile(
                text: "English",
                textColor: selectedLanguage == "English" ? .white : Color("GreyDarker"),
                backgroundColor: selectedLanguage == "English" ? Color("PurplePrimary") : Color("GreyLighter"),
                icon: selectedLanguage == "English" ? "checkmark" : ""
            ) {
                selectedLanguage = "English"  // Set the selected language to English
                print("Selected language: English")
            }
            
            // Russian Button
            CustomButtonProfile(
                text: "Russian",
                textColor: selectedLanguage == "Russian" ? .white : Color("GreyDarker"),
                backgroundColor: selectedLanguage == "Russian" ? Color("PurplePrimary") : Color("GreyLighter"),
                icon: selectedLanguage == "Russian" ? "checkmark" : ""
            ) {
                selectedLanguage = "Russian"  // Set the selected language to Russian
                print("Selected language: Russian")
            }
        }
        .padding(.top, 24)
        .navigationTitle("Language")
        Spacer()
    }
}

#Preview {
    LanguageView()
}

