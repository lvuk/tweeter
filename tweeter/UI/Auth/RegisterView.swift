//
//  RegisterView.swift
//  tweeter
//
//  Created by Luka Vuk on 13.11.2023..
//

import PhotosUI
import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var fullName = ""
    @State private var username = ""
    @State private var isShowingImagePicker = false
    
    @State private var profilePicutreItem: PhotosPickerItem?
    @State private var profilePicture: UIImage?
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Button {
                //do smth
                isShowingImagePicker.toggle()
            } label: {
                PhotosPicker(selection: $profilePicutreItem) {
                    if let profilePicture = profilePicture {
                        Image(uiImage: profilePicture)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 140)
                            .padding(.top, 88)
                            .padding(.bottom, 16)
                            .clipShape(Circle())
                    } else {
                        Image("profile-picture")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 140)
                            .padding(.top, 88)
                            .padding(.bottom, 16)
                    }
                }
                
            }
            .onChange(of: profilePicutreItem) { _ in
                Task {
                    if let data = try? await profilePicutreItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                profilePicture = uiImage
                                return
                        }
                    }
                }
                isShowingImagePicker.toggle()
            }
            
            VStack {
                CustomTextField(text: $fullName, placeholder: Text("Full Name"), imageName: "person")
                    .padding()
                    .background(Color.init(UIColor(white: 0, alpha: 0.05)))
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    .padding(.bottom)
                
                CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                    .padding()
                    .background(Color.init(UIColor(white: 0, alpha: 0.05)))
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    .padding(.bottom)
                
                CustomTextField(text: $username, placeholder: Text("Username"), imageName: "person")
                    .padding()
                    .background(Color.init(UIColor(white: 0, alpha: 0.05)))
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    .padding(.bottom)
                
                CustomSecureField(text: $password, placeholder: Text("Password"))
                    .padding()
                    .background(Color.init(UIColor(white: 0, alpha: 0.05)))
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    .padding(.bottom)
                    
            }
            
            Button {
                //do smth
                viewModel.register(email: email, password: password, username: username, fullName: fullName, profileImage: profilePicture)
            } label: {
                Text("Sign Up")
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
                Button {
                    //do smth
                    dismiss()
                } label: {
                    Text("Already have an account?")
                    Text("Sign In")
                        .font(.headline)
                        
                }
            }
            .foregroundStyle(.black)
            
        }
    }
}

#Preview {
    RegisterView()
}
