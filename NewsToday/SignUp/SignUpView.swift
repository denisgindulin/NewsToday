//
//  SignUpView.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 21.10.2024.
//

import SwiftUI

enum Field {
    case username
    case email
    case password
    case repeatPassword
}

struct SignUpView: View {
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome to NewsToDay")
                    .interFont(size: 24)
                Text("Hello, I guess you are new around here. You can start using the application after sign up.")
                    .interFont(type: .regular)
                    .foregroundStyle(.gray)
            }
            VStack(spacing: 16) {
                SignUpTextFields(focusedField: $focusedField)
                
                Button("Sign Up") {
                    //
                }
                .authButton()
            }
            Spacer()
            HStack {
                Text("Already have an account?")
                    .interFont(type: .medium)
                Button("Sign In") {
                    //
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .padding(.horizontal, 20)
        .padding(.top, 28)
        .contentShape(Rectangle())
        .onTapGesture {
            focusedField = nil
        }
        
    }
}

#Preview {
    SignUpView()
}
