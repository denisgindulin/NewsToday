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
    @StateObject var viewModel = SignInViewModel()
    @FocusState var focusedField: SignInField?
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome Back 👋")
                    .interFont(size: 24)
                    .foregroundStyle(.blackPrimary)
                Text("I am happy to see you again. You can continue where you left off by logging in")
                    .interFont(type: .regular)
                    .foregroundStyle(.greyPrimary)
            }
            SignInTextFields(viewModel: viewModel, focusedField: $focusedField)
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
    SignInView()
}
