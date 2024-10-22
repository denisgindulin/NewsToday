//
//  SignUpTextFields.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 22.10.2024.
//

import SwiftUI

struct SignUpTextFields: View {
    @State private var userName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    var focusedField: FocusState<Field?>.Binding
    
    var body: some View {
        VStack(spacing: 16) {
            AuthTextField(textFieldText: $userName, placeholder: "Username", imageName: "person", isSecure: false)
                .focused(focusedField, equals: .username)
            AuthTextField(textFieldText: $email, placeholder: "Email Adress", imageName: "envelope", isSecure: false)
                .focused(focusedField, equals: .email)
            AuthTextField(textFieldText: $password, placeholder: "Password", imageName: "exclamationmark.lock", isSecure: true)
                .focused(focusedField, equals: .password)
            AuthTextField(textFieldText: $repeatPassword, placeholder: "Repeat Password", imageName: "exclamationmark.lock", isSecure: true)
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
