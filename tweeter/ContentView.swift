//
//  ContentView.swift
//  tweeter
//
//  Created by Luka Vuk on 02.11.2023..
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
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
