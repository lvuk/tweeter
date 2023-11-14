//
//  CustomTextField.swift
//  tweeter
//
//  Created by Luka Vuk on 13.11.2023..
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    let placeholder: Text
    let imageName: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundStyle(Color.init(UIColor(white: 0, alpha: 0.60)))
                    .padding(.leading, 40)
                
            }
            
            HStack(spacing: 16) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                
                TextField("", text: $text)
                    .textInputAutocapitalization(.none)
            }
        }
    }
}

//#Preview {
//    CustomTextField(text: .constant(""), placeholder: Text("Email"))
//}
