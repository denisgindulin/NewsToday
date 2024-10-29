//
//  SignInView.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import SwiftUI

enum SignInField {
    case email, password
}

struct SignInView: View {
    @EnvironmentObject var localizationService: LocalizationService
    @StateObject var viewModel = SignInViewModel()
    @FocusState var focusedField: SignInField?
    
    @State private var isSignUp: Bool = false
    @State private var email = ""
    @State private var password = ""
    
    var disableSignIn: Bool {
        let isEmailEmpty = email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isPasswordEmpty = password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        return isEmailEmpty || isPasswordEmpty
    }
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading, spacing: 8) {
                Text(Resources.Text.authorizationSignInTitle.localized(localizationService.language))
                    .interFont(size: 24)
                    .foregroundStyle(.blackPrimary)
                Text(Resources.Text.authorizationSignInText.localized(localizationService.language))
                    .interFont(type: .regular)
                    .foregroundStyle(.greyPrimary)
            }
            VStack(spacing: 64) {
                SignInTextFields(email: $email, password: $password, focusedField: $focusedField)
                
                VStack {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .purplePrimary))
                    } else {
                        Button {
                            viewModel.signIn(email: email, password: password)
                        } label: {
                            Text(Resources.Text.signIn.localized(localizationService.language))
                                .authButton()
                                .opacity(disableSignIn ? 0.5 : 1)
                        }
                        .disabled(disableSignIn)
                    }
                    
                }
            }
            
            Spacer()
            
            HStack {
                Text(Resources.Text.dontHaveAnAccount.localized(localizationService.language))
                    .interFont(type: .medium)
                Button(Resources.Text.signUp.localized(localizationService.language)) {
                    withAnimation {
                        isSignUp.toggle()
                    }
                }
                .fullScreenCover(isPresented: $isSignUp) { SignUpView() }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .padding(.horizontal, 20)
        .padding(.top, 28)
        .frame(maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            focusedField = nil
        }
    }
}

#Preview {
    SignInView()
}
