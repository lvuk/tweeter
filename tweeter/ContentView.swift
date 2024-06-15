//
//  ContentView.swift
//  tweeter
//
//  Created by Luka Vuk on 02.11.2023..
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isShowingLogout = false
    @State private var isShowingProfile = false
    @ObservedObject var homeViewModel = HomeViewModel()
    @ObservedObject var searchViewModel = SearchViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                NavigationStack {
                    
                    TabView {
                        HomeView(viewModel: homeViewModel)
                            .tabItem {
                                Image(systemName: "house")
                                Text("Home")
                            }
                        
                        SearchView(viewModel: searchViewModel)
                            .tabItem {
                                Image(systemName: "magnifyingglass")
                                Text("Search")
                            }
                        
                        MessagesView()
                            .tabItem {
                                Image(systemName: "envelope")
                                Text("Messages")
                            }
                        
                    }
                    .confirmationDialog("Do you want to logout?", isPresented: $isShowingLogout, actions: {
                        Button("Profile") {
                            isShowingProfile.toggle()
                        }
                        Button("Logout", role: .destructive) { viewModel.logout()
                        }
                        Button("Cancel", role: .cancel) {}
                    })
                    .navigationTitle("Home")
                    .sheet(isPresented: $isShowingProfile) {
                        UserProfileView(user: viewModel.user!)
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                //do smth
                                isShowingLogout = true
                            } label: {
                                if let user = viewModel.user {
                                    KFImage(URL(string: user.profileImageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .clipped()
                                        .frame(width: 32, height: 32)
                                        .cornerRadius(28)
                                }
                                
//                                Image("batman")
//                                    .resizable()
//                                    .scaledToFill()
//                                    .clipped()
//                                    .frame(width:32, height: 32)
//                                    .clipShape(Circle())
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    
                }
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
