//
//  SignInTextFields.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 23.10.2024.
//

import SwiftUI

struct SignInTextFields: View {
    @ObservedObject var viewModel: SignInViewModel
    
    @State private var email = ""
    @State private var password = ""
    
    var focusedField: FocusState<SignInField?>.Binding
    
    var body: some View {
        VStack(spacing: 64) {
            VStack(spacing: 16) {
                VStack(alignment: .leading) {
                    AppTextField(textFieldText: $email, placeholder: "Email Adress", imageName: "envelope", isSecure: false)
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
            }
            
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .purplePrimary))
                } else {
                    Button {
                        viewModel.signIn(email: email, password: password)
                    } label: {
                        Text("Sign In")
                            .authButton()
                    }
                    if let signInError = viewModel.signInError {
                        ErrorText(text: signInError)
                    }
                }
                
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
