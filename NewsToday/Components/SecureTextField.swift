//
//  SecureTextField.swift
//  NewsToday
//
//  Created by Даниил Сивожелезов on 24.10.2024.
//

import SwiftUI

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
