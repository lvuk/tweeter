//
//  ContentView.swift
//  tweeter
//
//  Created by Luka Vuk on 02.11.2023..
//

import SwiftUI
import Kingfisher
import Firebase

struct ContentView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isShowingLogout = false
    @State private var isShowingProfile = false
    @ObservedObject var homeViewModel = HomeViewModel()
    @ObservedObject var searchViewModel = SearchViewModel()
    @State private var navigationTitle = "Home"
    
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
                            .onAppear{
                                navigationTitle = "Home"
                            }
                        
                        SearchView(viewModel: searchViewModel)
                            .tabItem {
                                Image(systemName: "magnifyingglass")
                                Text("Search")
                            }
                            .onAppear{
                                navigationTitle = "Search"
                            }
                        
                        if let user = viewModel.user {
                            UserProfileView(user: user)
                                .tabItem {
                                    Image(systemName: "person")
                                    Text("Profile")
                                }
                                .onAppear{
                                    navigationTitle = "Profile"
                                }
                        } else {
                            PlaceholderView()
                                .tabItem {
                                    Image(systemName: "person")
                                    Text("Profile")
                                }
                        }
                        
                        SettingsView()
                            .tabItem {
                                Image(systemName: "gear")
                                Text("Settings")
                            }
                            .onAppear{
                                navigationTitle = "Settings"
                            }
                    }
                    .navigationTitle(navigationTitle)
                    .navigationBarTitleDisplayMode(.automatic)
                    
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
