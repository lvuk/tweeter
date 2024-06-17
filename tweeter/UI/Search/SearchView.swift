//
//  SearchView.swift
//  tweeter
//
//  Created by Luka Vuk on 03.11.2023..
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
        
    var body: some View {
        ScrollView {
            SearchBar(text: $viewModel.searchText)
                .padding()

            
            VStack(alignment: .leading) {
                ForEach(viewModel.filteredUsers.isEmpty ? viewModel.users : viewModel.filteredUsers) { user in
                    NavigationLink(
                        destination: UserProfileView(user: user),
                        label: {
                            UserCell(user: user)
                        }
                    )
                    .foregroundStyle(.black)
                }
            }
            .padding(.leading)
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}

//#Preview {
//    NavigationStack {
//        SearchView()
//    }
//}
