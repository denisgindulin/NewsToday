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
    @FocusState private var focusedField: SignUpField?
    
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
                SignUpTextFields(viewModel: viewModel, focusedField: $focusedField)
            }
            
            Spacer()
        }
//        .ignoresSafeArea(.keyboard, edges: .bottom)
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
    SignUpView()
}
