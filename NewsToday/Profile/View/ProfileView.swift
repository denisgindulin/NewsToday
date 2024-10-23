//
//  ProfileView.swift
//  NewsToday
//
//  Created by Kate Kashko on 21.10.2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack (spacing: 24) {
                HStack(spacing: 24) {
                    Image("ProfileImage")
                        .frame(width: 72, height: 72)
                    VStack {
                        Text("Name")
                        Text("Email")
                    }
                    Spacer()
                }
                .padding()
                
                Spacer()

                // Language Button with NavigationLink
                NavigationLink(destination: LanguageView()) {
                    CustomButtonProfile(
                        text: "Language",
                        textColor: Color("GreyDarker"),
                        backgroundColor: Color("GreyLighter"),
                        icon: "chevron.right",
                        font: .headline
                    )
                }
                .buttonStyle(PlainButtonStyle())  // To avoid the default button styling
                
                // Terms & Conditions Button
                NavigationLink(destination: TermsAndConditionsView()) {
                    CustomButtonProfile(
                        text: "Terms & Conditions",
                        textColor: Color("GreyDarker"),
                        backgroundColor: Color("GreyLighter"),
                        icon: "chevron.right",
                        font: .headline
                    )
                }
                .buttonStyle(PlainButtonStyle())
                
                // Sign Out Button
                CustomButtonProfile(
                    text: "Sign Out",
                    textColor: Color("GreyDarker"),
                    backgroundColor: Color("GreyLighter"),
                    icon: "rectangle.portrait.and.arrow.right",
                    font: .headline,
                    action: {
                        print("Sign Out tapped!")
                    }
                )
            }
            .padding(.top, 24)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView()
}

#Preview("Russian") {
    ProfileView()
        .environment(\.locale, Locale(identifier: "RU"))
}


