//
//  UserCell.swift
//  tweeter
//
//  Created by Luka Vuk on 09.11.2023..
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack(spacing: 12) {
            Image("batman")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 56, height: 56)
                .cornerRadius(28)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("batman")
                    .font(.system(size: 14,weight: .semibold))
                
                Text("Bruce Wayne")
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
    }
}

#Preview {
    UserCell()
}
