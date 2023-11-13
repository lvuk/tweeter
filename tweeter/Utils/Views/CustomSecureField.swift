//
//  CustomSecureField.swift
//  tweeter
//
//  Created by Luka Vuk on 13.11.2023..
//

import SwiftUI

struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: Text
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundStyle(Color.init(UIColor(white: 0, alpha: 0.60)))
                    .padding(.leading, 40)
                
            }
            
            HStack(spacing: 16) {
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                
                SecureField("", text: $text)
                    
            }
        }
    }
}

//#Preview {
//    CustomSecureField()
//}
