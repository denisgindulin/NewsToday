//
//  SignUpTextFields.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 22.10.2024.
//

import SwiftUI

struct SignUpTextFields: View {
    @EnvironmentObject var localizationService: LocalizationService
    @Binding var userName: String
    @Binding var email: String
    @Binding var password: String
    @Binding var repeatPassword: String
    
    var focusedField: FocusState<SignUpField?>.Binding
    
    var body: some View {
        VStack(spacing: 16) {
                AppTextField(textFieldText: $userName,
                             placeholder: Resources.Text.username.localized(localizationService.language),
                             imageName: "person")
                    .focused(focusedField, equals: .username)
            
                AppTextField(textFieldText: $email,
                             placeholder: Resources.Text.email.localized(localizationService.language),
                             imageName: "envelope")
                    .focused(focusedField, equals: .email)
            
                AppTextField(textFieldText: $password,
                             placeholder: Resources.Text.password.localized(localizationService.language),
                             imageName: password.count >= 6 ? "lock.open" : "lock",
                             isSecure: true)
                    .focused(focusedField, equals: .password)

                AppTextField(textFieldText: $repeatPassword,
                             placeholder: Resources.Text.confirmPassword.localized(localizationService.language),
                             imageName: repeatPassword.count >= 6 && repeatPassword == password ? "lock.open" : "lock",
                             isSecure: true)
                    .focused(focusedField, equals: .repeatPassword)
        }
        .onSubmit {
            switch focusedField.wrappedValue {
            case .username:
                focusedField.wrappedValue = .email
            case .email:
                focusedField.wrappedValue = .password
            case .password:
                focusedField.wrappedValue = .repeatPassword
            case .repeatPassword:
                focusedField.wrappedValue = nil
            case nil:
                break
            }
        }
    }
}
