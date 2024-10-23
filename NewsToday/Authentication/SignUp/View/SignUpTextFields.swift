//
//  SignUpTextFields.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 22.10.2024.
//

import SwiftUI

struct SignUpTextFields: View {
    @ObservedObject var viewModel: SignUpViewModel
    
    @State private var userName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    
    var focusedField: FocusState<SignUpField?>.Binding
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading) {
                AppTextField(textFieldText: $userName, placeholder: "Username", imageName: "person")
                    .focused(focusedField, equals: .username)
                if let nameError = viewModel.nameError {
                    ErrorText(text: nameError)
                }
            }
            
            VStack(alignment: .leading) {
                AppTextField(textFieldText: $email, placeholder: "Email Adress", imageName: "envelope")
                    .focused(focusedField, equals: .email)
                if let emailError = viewModel.emailError {
                    ErrorText(text: emailError)
                }
            }
            
            VStack(alignment: .leading) {
                AppTextField(textFieldText: $password, placeholder: "Password", imageName: "exclamationmark.lock", isSecure: true)
                    .focused(focusedField, equals: .password)
                if let passwordError = viewModel.passwordError {
                    ErrorText(text: passwordError)
                }
            }
            
            VStack(alignment: .leading) {
                AppTextField(textFieldText: $repeatPassword, placeholder: "Repeat Password", imageName: "exclamationmark.lock", isSecure: true)
                    .focused(focusedField, equals: .repeatPassword)
                if let repeatPasswordError = viewModel.repeatPasswordError {
                    ErrorText(text: repeatPasswordError)
                }
            }
            
            VStack(alignment: .leading) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .purplePrimary))
                } else {
                    Button {
                        print("Sign Up")
                        viewModel.createUser(name: userName, email: email, password: password, repeatPassword: repeatPassword)
                    } label: {
                        Text("Sign Up")
                            .authButton()
                    }
                    if let registrationError = viewModel.registrationError {
                        ErrorText(text: registrationError)
                    }
                }
            }
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
