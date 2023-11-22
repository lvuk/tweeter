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
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                NavigationStack {
                    
                    TabView {
                        HomeView()
                            .tabItem {
                                Image(systemName: "house")
                                Text("Home")
                            }
                        
                        SearchView()
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
                        Button("Logout", role: .destructive) { viewModel.logout()}
                        Button("Cancel", role: .cancel) {}
                    })
                    .navigationTitle("Home")
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
