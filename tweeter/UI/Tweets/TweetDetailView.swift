//
//  TweetDetailView.swift
//  tweeter
//
//  Created by Luka Vuk on 22.11.2023..
//

import SwiftUI
import Kingfisher

struct TweetDetailView: View {
    @Environment(\.dismiss) var dismiss
    let tweet: Tweet
    @State private var isShowingDelete = false
    @ObservedObject var viewModel: TweetActionsViewModel
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.viewModel = TweetActionsViewModel(tweet: tweet)
    }
    
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
                
                Spacer()
                
                if viewModel.checkIfUserTweetOwner() {
                    Button {
                        //toggle notification
                        NotificationPublisher.instance.publishShowDeleteDialog()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                    }
                }
            }
            
            Text(tweet.caption)
                .font(.system(size: 22))
            
            Text("\(tweet.timestamp.dateValue().formatted(date: .numeric, time: .standard))")
                .foregroundStyle(.gray)
            
            Divider()
            TweetActionsView(tweet: tweet)
                
            
            Divider()
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, -40)
        .onReceive(NotificationCenter.default.publisher(for: .showDeleteDialog)) { _ in
            isShowingDelete = true
        }
        .confirmationDialog("Are you sure you want to delete this tweet?", isPresented: $isShowingDelete) {
            Button("Delete", role:.destructive) {
                //delete tweet
                viewModel.deleteTweet()
                dismiss()
                
            }
            
            Button("Cancel") { }
        }
    }
}

//#Preview {
//    TweetDetailView()
//}
