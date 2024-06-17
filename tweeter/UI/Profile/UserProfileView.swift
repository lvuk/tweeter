//
//  UserProfileView.swift
//  tweeter
//
//  Created by Luka Vuk on 09.11.2023..
//

import SwiftUI

struct UserProfileView: View {
    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    @State private var selectedFilter: TweetFilterOptions = .tweets
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }

    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView(viewModel: viewModel, isFollowed: $viewModel.isFollowed)
                    .padding(.top, 40)
                
                FilterButtonView(selectedOption: $selectedFilter)
                    .padding(.top)
//                FilterButtonView()
//                    .padding(.top)
                
                ForEach(viewModel.userTweets) { tweet in
                    TweetCell(tweet: tweet)
                        .padding()
                }
                
                
                
                
            }
        }
        .navigationTitle(user.username)
    }
}

//#Preview {
//    UserProfileView()
//}
