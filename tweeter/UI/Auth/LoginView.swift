//
//  LoginView.swift
//  tweeter
//
//  Created by Luka Vuk on 13.11.2023..
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            Image("logo-twitter")
                .resizable()
                .scaledToFill()
                .frame(width: 220, height: 100)
                .padding(.top, 88)
                .padding(.bottom, 32)
            
            VStack {
                CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                    .padding()
                    .background(Color.init(UIColor(white: 0, alpha: 0.05)))
                    .clipShape(Capsule())
                    .padding()
                
                CustomSecureField(text: $password, placeholder: Text("Password"))
                    .padding()
                    .background(Color.init(UIColor(white: 0, alpha: 0.05)))
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    
            }
            
            HStack {
                Spacer()
                
                Button {
                    //do smth
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .bold()
                        .foregroundStyle(.black)
                        .padding(.top, 8)
                        .padding(.trailing)
                }
            }
            
            Button {
                //do smth
            } label: {
                Text("Sign In")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 150)
                    .background(Color.init(UIColor(white: 0, alpha: 1)))
                    .clipShape(Capsule())
                    .padding(.top)
            }
            
            Spacer()
            
            HStack {
                Text("Don't have an account?")
                Button {
                    //do smth
                } label: {
                    Text("Sign up")
                        .font(.headline)
                        .foregroundStyle(.black)
                }
            }
            
        }
    }
}

#Preview {
    LoginView()
}
