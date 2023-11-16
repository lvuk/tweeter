//
//  UserCell.swift
//  tweeter
//
//  Created by Luka Vuk on 09.11.2023..
//

import SwiftUI
import Kingfisher


struct UserCell: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 56, height: 56)
                .cornerRadius(28)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.username)
                    .font(.system(size: 14,weight: .semibold))
                
                Text(user.fullName)
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
    }
}

//#Preview {
//    UserCell()
//}
