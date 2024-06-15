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
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }

    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView(viewModel: viewModel, isFollowed: $viewModel.isFollowed)
                    .padding(.top, 40)
                
                VStack {
                   Text("Tweets")
                        .foregroundStyle(.blue)
                        
                    Rectangle()
                        .frame(width: 60, height: 3)
                        .foregroundColor(.blue)
                    
                    ForEach(0..<9) { _ in
//                        TweetCell()
                    }
                }
                .padding(.top)
                
            }
        }
        .navigationTitle(user.username)
    }
}

//#Preview {
//    UserProfileView()
//}
