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
    @State private var showingImagePicker = false 
    @State private var avatarImage: UIImage? = nil
    
    var body: some View {
        NavigationView {
            VStack (spacing: 24) {
                HStack(spacing: 24) {
                    if let imageData = viewModel.avatarImageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 72, height: 72)
                            .clipShape(Circle())
                            .onTapGesture {
                                showingImagePicker = true
                            }
                    } else {
                        Image(systemName: "photo.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 72, height: 72)
                            .foregroundColor(Color("GreyDarker"))
                            .onTapGesture {
                                showingImagePicker = true
                            }
                    }
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
                        viewModel.signOut(authViewModel: authViewModel)
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
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $avatarImage, isPresented: $showingImagePicker)
            }
            .onChange(of: avatarImage) { newImage in
                if let newImage = newImage {
                    viewModel.uploadProfileImage(image: newImage)
                }
            }
            .onAppear {
                viewModel.fetchProfileImage() // Fetch the avatar when the view appears
            }
        }
    }
}

#Preview("Russian") {
    ProfileView()
        .environment(\.locale, Locale(identifier: "RU"))
}


