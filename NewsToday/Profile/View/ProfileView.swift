//
//  ProfileView.swift
//  NewsToday
//
//  Created by Kate Kashko on 21.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    @EnvironmentObject var localizationService: LocalizationService
    @EnvironmentObject var authViewModel: AuthViewModel

    @State private var showingImagePicker = false
    @State private var avatarImage: UIImage = UIImage(resource: .placeholder)
    
    var body: some View {
        NavigationView {
            VStack (spacing: 24) {
                HStack(spacing: 24) {
                    WebImage(url: URL(string: authViewModel.userAvatar ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Image(uiImage: avatarImage)
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(width: 72, height: 72)
                    .clipShape(Circle())
                    .onTapGesture {
                        showingImagePicker = true
                    }
                    .sheet(isPresented: $showingImagePicker) { ImagePicker(image: $avatarImage) }
                    
                    VStack(alignment: .leading) {
                        Text(authViewModel.user?.name ?? "No Name")
                            .interFont(size: 24)
                            .foregroundColor(Color("BlackPrimary"))
                        Text(authViewModel.user?.email ?? "No Email")
                            .interFont(size: 16)
                            .foregroundColor(Color("GreyPrimary"))
                    }
                    Spacer()
                }
                .padding()
                
                // Language Button with NavigationLink
                NavigationLink(destination: LanguageView()) {
                    CustomButtonProfile(
                        text: Resources.Text.lang.localized(localizationService.language),
                        textColor: Color("GreyDarker"),
                        backgroundColor: Color("GreyLighter"),
                        icon: "chevron.right"
                    )
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
                
                // Terms & Conditions Button
                NavigationLink(destination: TermsAndConditionsView()) {
                    CustomButtonProfile(
                        text: Resources.Text.termsAndConditions.localized(localizationService.language),
                        textColor: Color("GreyDarker"),
                        backgroundColor: Color("GreyLighter"),
                        icon: "chevron.right"
                    )
                }
                .buttonStyle(PlainButtonStyle())
                
                // Sign Out Button
                CustomButtonProfile(
                    text: Resources.Text.signOut.localized(localizationService.language),
                    textColor: Color("GreyDarker"),
                    backgroundColor: Color("GreyLighter"),
                    icon: "rectangle.portrait.and.arrow.right",
                    action: {
                        authViewModel.signOut()
                    }
                )
            }
            .padding(.vertical, 24)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(Resources.Text.profile.localized(localizationService.language))
                        .interFont(size: 24)
                        .foregroundColor(Color("BlackPrimary"))
                }
            }
        }
    }
}

#Preview("Russian") {
    ProfileView()
        .environment(\.locale, Locale(identifier: "RU"))
}


