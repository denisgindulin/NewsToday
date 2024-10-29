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
                    .focused($isFocused)
            } else {
                TextField(placeholder, text: $textFieldText)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
            }
        }
        .padding(.horizontal, 10)
        .frame(maxHeight: 55)
        .background(isFocused ? .clear : .greyLighter)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            if isFocused {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.purplePrimary), lineWidth: 1)
            }
        }
        .onTapGesture {
            isFocused = true
        }
    }
}
