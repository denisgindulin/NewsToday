//
//  SignInTextFields.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 23.10.2024.
//

import SwiftUI

struct SignInTextFields: View {
    @EnvironmentObject var localizationService: LocalizationService
    @Binding var email: String
    @Binding var password: String
    
    var focusedField: FocusState<SignInField?>.Binding
    
    var body: some View {
        VStack(spacing: 64) {
            VStack(spacing: 16) {
                AppTextField(textFieldText: $email,
                             placeholder: Resources.Text.email.localized(localizationService.language),
                             imageName: "envelope", isSecure: false)
                    .focused(focusedField, equals: .email)
                
                AppTextField(textFieldText: $password,
                             placeholder: Resources.Text.password.localized(localizationService.language),
                             imageName: "exclamationmark.lock", isSecure: true)
                    .focused(focusedField, equals: .password)
            }
        }
        .onSubmit {
            switch focusedField.wrappedValue {
            case .email:
                focusedField.wrappedValue = .password
            case .password:
                focusedField.wrappedValue = nil
            case nil:
                break
            }
        }
    }
}
