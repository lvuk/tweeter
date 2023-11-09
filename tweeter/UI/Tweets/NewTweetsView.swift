//
//  NewTweetsView.swift
//  tweeter
//
//  Created by Luka Vuk on 09.11.2023..
//

import SwiftUI

struct NewTweetsView: View {
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack{
                HStack {
                    Image("batman")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                    
                    Text("Whats happening?")
                        .foregroundStyle(.gray)
                    
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //do smth
                    } label: {
                        Text("Tweet")
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.8))
                            .foregroundStyle(.white)
                            .clipShape(Capsule())
                    }
                }
            }
        }
    }
}

#Preview {
    NewTweetsView()
}
