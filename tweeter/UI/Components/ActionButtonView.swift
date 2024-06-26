//
//  ActionButtonView.swift
//  tweeter
//
//  Created by Luka Vuk on 09.11.2023..
//
import SwiftUI

struct ActionButtonView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Binding var isFollowed: Bool
    
    var body: some View {
        if viewModel.user.isCurrentUser {
            NavigationLink(destination: EditProfileView(viewModel: viewModel)) {
                Text("Edit Profile")
                    .frame(width: 360, height: 40)
                    .foregroundStyle(.blue)
                    .clipShape(Capsule())
                    .overlay(
                        RoundedRectangle(cornerRadius: 25.0)
                            .stroke(Color.blue, lineWidth: 1)
                    )

            }
        } else {
            HStack {
                Button {
                    //action for follow
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    Text(isFollowed ? "Unfollow" : "Follow ")
                        .frame(width: 360, height: 40)
                        .background(isFollowed ? Color.clear : Color.blue)
                        .foregroundStyle(isFollowed ? Color.blue : Color.white)
                        .clipShape(Capsule())
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 25.0).stroke(Color.blue, lineWidth: 1)
                )
            }
        }
    }
}
