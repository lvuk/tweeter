//
//  HomeView.swift
//  tweeter
//
//  Created by Luka Vuk on 03.11.2023..
//

import SwiftUI

struct HomeView: View {
    @State var isShowingNewTweet = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            ScrollView {
                LazyVStack {
                    ForEach(0..<10) { _ in
                        TweetCell()
                            .padding(.horizontal)
                    }
                }
            }
            
            Button {
                //do smth
//                isShowingNewTweet.toggle()
                viewModel.logout()
                
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
                NewTweetsView()
            }
            
        }
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}
