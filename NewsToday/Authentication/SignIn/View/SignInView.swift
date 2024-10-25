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
    
    @State private var isSignUp: Bool = false
    @State private var email = ""
    @State private var password = ""
    
    var disableSignIn: Bool {
        let isEmailEmpty = email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isPasswordEmpty = password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        return isEmailEmpty || isPasswordEmpty
    }
    
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
            VStack(spacing: 64) {
                SignInTextFields(email: $email, password: $password, focusedField: $focusedField)
                
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
                                .opacity(disableSignIn ? 0.5 : 1)
                        }
                        .disabled(disableSignIn)
                    }
                    
                }
            }
            
            Spacer()
            
            HStack {
                Text(isSignUp ? "Already have an account?" : "Don't have an account?")
                    .interFont(type: .medium)
                Button(isSignUp ? "Sign In" : "Sign Up") {
                    withAnimation {
                        isSignUp.toggle()
                    }
                }
                .fullScreenCover(isPresented: $isSignUp) { SignUpView() }
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

#Preview {
    SignInView()
}
