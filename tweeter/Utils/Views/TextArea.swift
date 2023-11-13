//
//  TextArea.swift
//  tweeter
//
//  Created by Luka Vuk on 09.11.2023..
//

import SwiftUI

struct TextArea: View {
    @Binding var text: String
    let placeholder: String

    init(placeholder: String, text: Binding<String>) {
        self._text = text
        self.placeholder = placeholder
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .padding(4)
                .background(.clear)
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
//                    .zIndex(1)
//                    .background(.clear)
            }

            
//                .background(Color.clear)
        }
        .font(.body)
    }
}

//#Preview {
//    TextArea(text: .constant, placeholder: <#T##String#>)
//}
