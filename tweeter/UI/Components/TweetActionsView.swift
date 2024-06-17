//
//  TweetActionsView.swift
//  tweeter
//
//  Created by Luka Vuk on 15.06.2024..
//

import SwiftUI

struct TweetActionsView: View {
    let tweet: Tweet
    @ObservedObject var viewModel: TweetActionsViewModel
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.viewModel = TweetActionsViewModel(tweet: tweet)
    }
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                if viewModel.didLike {
                    viewModel.unlikeTweet()
                } else {
                    viewModel.likeTweet()
                }
            } label: {
                Image(systemName: viewModel.didLike ? "heart.fill" : "heart")
                    .foregroundColor(viewModel.didLike ? .red : .gray)
                
//                Text("\(viewModel.likes)")
            }
            
            Spacer()
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
                Image(systemName: "bookmark")
            }
            
            Spacer()
          
        }
        .padding(.horizontal)
        .foregroundStyle(.gray)
        
    }
}

//#Preview {
//    TweetActionsView()
//}
