//
//  ContentView.swift
//  tweeter
//
//  Created by Luka Vuk on 02.11.2023..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
    }
}

#Preview {
    ContentView()
}
