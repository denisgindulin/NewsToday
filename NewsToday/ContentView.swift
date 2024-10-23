//
//  ContentView.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 20.10.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if let _ = authViewModel.user {
                NewsView()
            } else {
                AuthView()
            }
        }
    }
}

#Preview {
    ContentView()
}
