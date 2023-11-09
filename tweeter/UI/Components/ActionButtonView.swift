//
//  ActionButtonView.swift
//  tweeter
//
//  Created by Luka Vuk on 09.11.2023..
//

import SwiftUI

struct ActionButtonView: View {
    let isCurrentUser: Bool
    
    var body: some View {
        if isCurrentUser {
            Button {
                //do smth
            } label: {
                Text("Edit Profile")
                    .frame(width: 360, height: 40)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }
        } else {
            HStack {
                Button {
                    //do smth
                } label: {
                    Text("Follow")
                        .frame(width: 360, height: 40)
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
            }
        }
    }
}

#Preview {
    ActionButtonView(isCurrentUser: false)
}
