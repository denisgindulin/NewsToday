//
//  ProfileView.swift
//  NewsToday
//
//  Created by Kate Kashko on 21.10.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var localizationService: LocalizationService
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showingImagePicker = false  // Для отображения модального окна выбора изображения
    @State private var avatarImage: UIImage? = nil // Хранение выбранного изображения
    
    var body: some View {
        NavigationView {
            VStack (spacing: 24) {
                HStack(spacing: 24) {
                    if let avatarImage = avatarImage {
                        Image(uiImage: avatarImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 72, height: 72)
                            .clipShape(Circle())
                            .onTapGesture {
                                showingImagePicker = true
                            }
                    } else {
                        Image("ProfileImage")  // Заглушка по умолчанию
                            .resizable()
                            .frame(width: 72, height: 72)
                            .clipShape(Circle())
                            .onTapGesture {
                                showingImagePicker = true
                            }
                    }
                    VStack(alignment: .leading) {
                        Text(authViewModel.user?.name ?? "No Name")
                            .font(.headline)
                        Text(authViewModel.user?.email ?? "No Email")
                            .font(.subheadline)
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
                .buttonStyle(PlainButtonStyle())  // To avoid the default button styling
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
                        viewModel.signOut(authViewModel: authViewModel)
                    }
                )
            }
            .padding(.vertical, 24)
            .navigationTitle(Resources.Text.profile.localized(localizationService.language))
//            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $avatarImage, isPresented: $showingImagePicker)
        }
    }
}

#Preview("Russian") {
    ProfileView()
        .environment(\.locale, Locale(identifier: "RU"))
}


