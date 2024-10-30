//
//  NewsPresentCardView.swift
//  NewsToday
//
//  Created by Руслан on 23.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsPresentCardView: View {
    
    @State private var isFullScreen = false
    var arcticle: Article
    
    var action: () -> ()
    
    var body: some View {
        Button {
            isFullScreen = true
        } label: {
            ZStack {
                WebImage(url: URL(string: arcticle.imageURL ?? ""))
                    .resizable()
                    .opacity(0.7)
                
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "bookmark")
                                .foregroundColor(.white)
                        }
                    }
                    Spacer ()
                    
                    Text(arcticle.category?.first ?? "")
                        .textCase(.uppercase)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                    
                    Text(arcticle.title ?? "")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    
                }
                .multilineTextAlignment(.leading)
                .padding(.all, 24)
            }
            .background(Color.black)
            .frame(width: 256, height: 256)
            .cornerRadius(12)
        }
        .fullScreenCover(isPresented: $isFullScreen) {
            NewsCardView(arcticle: arcticle)
        }
    }
}
