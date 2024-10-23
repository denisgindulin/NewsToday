//
//  AppTextField.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 22.10.2024.
//

import SwiftUI

struct AppTextField: View {
    @FocusState private var isFocused: Bool
    
    @Binding var textFieldText: String
    
    let placeholder: String
    let imageName: String
    
    var isSecure: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(isFocused ? .purplePrimary : .greyPrimary)
            if isSecure {
                SecureTextField(textFieldText: $textFieldText, placeholder: placeholder)
            } else {
                TextField(placeholder, text: $textFieldText)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
            }
        }
        .padding()
        .background(isFocused ? .clear : .greyLighter)
        .overlay {
            if isFocused {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.purplePrimary), lineWidth: 1)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct SecureTextField: View {
    @State var isShowPassword: Bool = true
    @Binding var textFieldText: String
    
    let placeholder: String
    
    var body: some View {
        HStack {
            if isShowPassword {
                SecureField(placeholder, text: $textFieldText)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
            } else {
                TextField(placeholder, text: $textFieldText)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
            }
            
            Button("", systemImage: "eye") {
                isShowPassword.toggle()
            }
            .foregroundStyle(.greyPrimary)
            
        }
    }
}
