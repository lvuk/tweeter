//
//  ContentView.swift
//  tweeter
//
//  Created by Luka Vuk on 02.11.2023..
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @Environment(\.dismiss) var dismiss
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
                    .navigationTitle("Home")
                    .sheet(isPresented: $isShowingProfile) {
                        NavigationView {
                            VStack {
                                UserProfileView(user: viewModel.user!)
                                    .padding(.top, -20)
                            }
                            .toolbar {
                                Button("Done") { isShowingProfile = false }
                            }
                        }
                    }
                    .confirmationDialog("Do you want to logout?", isPresented: $isShowingLogout, actions: {
                        Button("Profile") { isShowingProfile = true }
                        Button("Logout", role: .destructive) { viewModel.logout()
                        }
                        Button("Cancel", role: .cancel) {}
                    })
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
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
