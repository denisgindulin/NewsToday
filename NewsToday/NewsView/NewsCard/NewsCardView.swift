//
//  NewsCardView.swift
//  NewsToday
//
//  Created by Руслан on 23.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShareText: Identifiable {
    let id = UUID()
    let text: String
}

struct NewsCardView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var shareText: ShareText?
    
    var arcticle: Article
    
    var body: some View {
        
        GeometryReader { geo in
            VStack(spacing: 0) {
                ZStack(alignment: .top) {
                    WebImage(url: URL(string: arcticle.imageURL ?? ""))
                        .resizable()
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: geo.size.height / 2.4, alignment: .center)
                        .opacity(0.5)
                    
                    textOnImageHeader
                }
                .background(Color.black)
                
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Text("Results")
                                .font(.system(size: 16, weight: .bold))
                                .padding(.bottom, 8)
                                .padding(.top, 24)
                            
                            Spacer()
                        }
                        
                        Text(arcticle.description ?? "")
                            .font(.system(size: 16, weight: .light))
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                }
            }
            .sheet(item: $shareText) { shareText in
                ActivityView(text: shareText.text)
            }
        }
    }
}

extension NewsCardView {
    
    var textOnImageHeader: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            HStack {
                Button(action: { dismiss() },
                       label:  { Image(systemName: "arrow.backward") })
                
                Spacer()
                
                Button(action: {},
                       label:  { Image(systemName: "bookmark") })
            }
            
            HStack {
                Spacer()
                
                Button(action: { shareText = ShareText(text: arcticle.link ?? "")},
                       label:  { Image(systemName: "arrowshape.turn.up.right")})
            }
            
            articleText
            
        }
        .padding(.horizontal, 20)
        .padding([.top, .bottom], 16)
        .foregroundColor(.white)
    }
    
    var articleText: some View {
        
        Group {
            Text(arcticle.category?.first ?? "")
                .textCase(.uppercase)
                .font(.system(size: 12, weight: .bold))
                .padding(.horizontal, 16)
                .padding([.top, .bottom], 8)
                .background(Color.purplePrimary)
                .cornerRadius(16)
            
            Text(arcticle.title ?? "")
                .font(.system(size: 20, weight: .bold))
            
            VStack(alignment: .leading, spacing: 0){
                Text(arcticle.creator?.first ?? "")
                    .font(.system(size: 16, weight: .bold))
                
                Text("autor")
                    .font(.system(size: 16, weight: .light))
            }
        }
    }
}
