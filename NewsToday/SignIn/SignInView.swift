//
//  SignInView.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome Back 👋")
                    .interFont(size: 24)
                Text("I am happy to see you again. You can continue where you left off by logging in")
                    .interFont(type: .regular)
                    .foregroundStyle(.gray)
            }
            
            VStack(spacing: 64) {
                VStack(spacing: 16) {
                    AuthTextField(textFieldText: $email, placeholder: "Email Adress", imageName: "envelope", isSecure: false)
                    AuthTextField(textFieldText: $password, placeholder: "Password", imageName: "exclamationmark.lock", isSecure: true)
                }
                Button("Sign Up") {
                    //
                }
                .authButton()
            }
            Spacer()
            HStack {
                Text("Don't have an account?")
                    .interFont(type: .medium)
                Button("Sign Up") {
                    //
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 28)
    }
}

#Preview {
    SignInView()
}
