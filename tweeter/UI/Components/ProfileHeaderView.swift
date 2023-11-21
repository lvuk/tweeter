//
//  ProfileHeader.swift
//  tweeter
//
//  Created by Luka Vuk on 09.11.2023..
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    let viewModel: ProfileViewModel
    @Binding var isFollowed: Bool
    
    var body: some View {
        VStack {
            KFImage(URL(string: viewModel.user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .shadow(radius: 15)
            
            Text(viewModel.user.fullName)
                .font(.system(size: 16, weight: .semibold))
            
            Text("@\(viewModel.user.username)")
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            Text("Billionare by day, dark knight by night")
                .font(.system(size: 14))
                .padding(.top, 8)
            
            HStack(spacing: 42) {
                VStack {
                    Text("12")
                        .font(.system(size: 16)).bold()
                    
                    Text("Followers")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
                
                VStack {
                    Text("12")
                        .font(.system(size: 16)).bold()
                    
                    Text("Following")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
            }
            .padding()
            
            ActionButtonView(viewModel: viewModel, isFollowed: $isFollowed)
            
            Spacer()
        }
    }
}

//#Preview {
//    ProfileHeaderView()
//}
