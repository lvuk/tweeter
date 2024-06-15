//
//  TweetDetailView.swift
//  tweeter
//
//  Created by Luka Vuk on 22.11.2023..
//

import SwiftUI
import Kingfisher

struct TweetDetailView: View {
    let tweet: Tweet
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                KFImage(URL(string: tweet.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(tweet.fullName).font(.system(size: 14).weight(.semibold))
                    
                    Text(tweet.username).font(.system(size: 14)).foregroundStyle(.gray)
                }
            }
            
            Text(tweet.caption)
                .font(.system(size: 22))
            
            Text("7:22 PM﹒15/6/2024")
                .foregroundStyle(.gray)
            
            Divider()
            
            HStack {
                Text(String(tweet.likes)).fontWeight(.semibold)
                Text("likes")
            }
            
            Divider()
            
            HStack {
                Spacer()
                Button {
                    //do smth
                } label: {
                    Image(systemName: "bubble.left")
                }
                Spacer()
                Spacer()
                Button {
                    //do smth
                } label: {
                    Image(systemName: "heart")
                }
                Spacer()
                Spacer()
                Button {
                    //do smth
                } label: {
                    Image(systemName: "bookmark")
                }
                Spacer()
              
            }
            .padding(.horizontal)
            .foregroundStyle(.gray)
            
            Divider()
            Spacer()
        }
        .padding()
    }
}

//#Preview {
//    TweetDetailView()
//}
