//
//  AuthView.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 23.10.2024.
//

import SwiftUI

struct AuthView: View {
    @State private var isSignUp: Bool = false
    
    var body: some View {
        VStack {
            if isSignUp {
                SignUpView()
                    .transition(.move(edge: .leading))
            } else {
                SignInView()
                    .transition(.move(edge: .trailing))
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
            }
        }
    }
}
