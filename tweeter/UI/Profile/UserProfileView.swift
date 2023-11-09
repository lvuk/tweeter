//
//  UserProfileView.swift
//  tweeter
//
//  Created by Luka Vuk on 09.11.2023..
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView()
                
                VStack {
                   Text("Tweets")
                        .foregroundStyle(.blue)
                        
                    Rectangle()
                        .frame(width: 60, height: 3)
                        .foregroundColor(.blue)
                    
                    ForEach(0..<9) { _ in
                        TweetCell()
                    }
                }
                .padding(.top)
                
            }
        }
        .navigationTitle("batman")
    }
}

#Preview {
    UserProfileView()
}
