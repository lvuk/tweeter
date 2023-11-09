//
//  SearchView.swift
//  tweeter
//
//  Created by Luka Vuk on 03.11.2023..
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    
    var body: some View {
        ScrollView {
            SearchBar(text: $text)
                .padding()
            
            VStack(alignment: .leading) {
                ForEach(0..<10) { _ in
                    UserCell()
                }
            }
            .padding(.leading)
        }
        .navigationTitle("Search")
    }
}

#Preview {
    SearchView()
}
