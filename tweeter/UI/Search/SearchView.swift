//
//  SearchView.swift
//  tweeter
//
//  Created by Luka Vuk on 03.11.2023..
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        ScrollView {
            SearchBar(text: $text)
                .padding()
            
            VStack(alignment: .leading) {
                ForEach(viewModel.users) { user in
                    NavigationLink(
                        destination: UserProfileView(),
                        label: {
                            UserCell(user: user)
                        }
                    )
                    .foregroundStyle(.black)
                }
            }
            .padding(.leading)
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
