//
//  SignUpView.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import SwiftUI

enum SignUpField {
    case username
    case email
    case password
    case repeatPassword
}

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: SignUpField?
    
    @State private var userName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    
    var disableSignUp: Bool {
        let isNameEmpty = userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isEmailEmpty = email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isPasswordEmpty = password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isRepeatPasswordEmpty = repeatPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        let isPasswordMatches = password == repeatPassword
        
        return isNameEmpty || isEmailEmpty || isPasswordEmpty || isRepeatPasswordEmpty || !isPasswordMatches
    }
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome to NewsToDay")
                    .interFont(size: 24)
                    .foregroundStyle(.blackPrimary)
                Text("Hello, I guess you are new around here. You can start using the application after sign up.")
                    .interFont(type: .regular)
                    .foregroundStyle(.greyPrimary)
            }
            VStack(spacing: 16) {
                SignUpTextFields(userName: $userName, email: $email, password: $password, repeatPassword: $repeatPassword, focusedField: $focusedField)
                
                VStack {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .purplePrimary))
                    } else {
                        Button {
                            viewModel.createUser(name: userName, email: email, password: password, repeatPassword: repeatPassword)
//                            dismiss()
                        } label: {
                            Text("Sign Up")
                                .authButton()
                                .opacity(disableSignUp ? 0.5 : 1)
                        }
                        .disabled(disableSignUp)
                    }
                }
            }
            Spacer()
            
            HStack {
                Text("Already have an account?")
                    .interFont(type: .medium)
                Button("Sign In") {
                    dismiss()
                }
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

//#Preview {
//    SignUpView()
//}
