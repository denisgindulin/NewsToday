//
//  EmptyNewsView.swift
//  NewsToday
//
//  Created by Руслан on 3.11.2024.
//

import SwiftUI

struct EmptyNewsView: View {
    
    var body: some View {
        HStack {
        
            Rectangle()
                .foregroundColor(.gray)
                .cornerRadius(12)
                .frame(width: 96, height: 96)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Rectangle()
                    .foregroundColor(.gray)
                    .cornerRadius(12)
                    .frame(width: 45, height: 10)
                
                Rectangle()
                    .foregroundColor(.gray)
                    .cornerRadius(12)
                    .frame(width: 100, height: 10)
            }
            Spacer()
        }
        .padding(.bottom, 8)
        .padding(.horizontal, 20)
        .shimmer(configuration: .default)
    }
}
