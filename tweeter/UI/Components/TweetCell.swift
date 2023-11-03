//
//  TweetCell.swift
//  tweeter
//
//  Created by Luka Vuk on 03.11.2023..
//

import SwiftUI

struct TweetCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 12) {
                Image("venom")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("Eddie Brock")
                            .font(.system(size: 14, weight: .semibold))
                        
                        Text("@Venom •")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        Text("2m ago")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    
                    Text("This is my first tweet here")
                }
                
                
            }
            .padding(.bottom)
            .padding(.trailing)
            
            
            HStack {
                Spacer()
                Button {
                    //do smth
                } label: {
                    Image(systemName: "bubble.left")
                }
                Spacer()
                Spacer()
                Button {
                    //do smth
                } label: {
                    Image(systemName: "heart")
                }
                Spacer()
                Spacer()
                Button {
                    //do smth
                } label: {
                    Image(systemName: "bookmark")
                }
                Spacer()
              
            }
            .padding(.horizontal)
            .foregroundStyle(.gray)
            
            Divider()
                .padding(.vertical)
        }
    }
}

#Preview {
    TweetCell()
}
