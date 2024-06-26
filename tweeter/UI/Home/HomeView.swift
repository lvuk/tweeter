//
//  HomeView.swift
//  tweeter
//
//  Created by Luka Vuk on 03.11.2023..
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @State var isShowingNewTweet = false
 
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.tweets) { tweet in
                        NavigationLink(destination: TweetDetailView(tweet: tweet)) {
                            TweetCell(tweet: tweet)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            
            Button {
                //do smth
                isShowingNewTweet.toggle()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
            }
            .background(Color.blue.opacity(0.7))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $isShowingNewTweet) {
                NewTweetsView(homeViewModel: viewModel)
            }
        }
        .onAppear { viewModel.fetchTweets() }
    }
}

//#Preview {
//    NavigationStack{
//        HomeView()
//    }
//}
