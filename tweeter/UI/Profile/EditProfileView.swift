//
//  EditProfileView.swift
//  tweeter
//
//  Created by Luka Vuk on 17.06.2024..
//
import SwiftUI
import Kingfisher

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    
    @State private var fullNameTextField: String = ""
    @State private var descriptionTextField: String = ""
    @State private var usernameTextField: String = ""
    
    var body: some View {
        Form {
            Section {
                HStack(alignment: .center) {
                    KFImage(URL(string: viewModel.user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(radius: 15)
                    Spacer()
                    
                    Button("Edit Photo") {
                        // Select new photo from library
                    }
                    Spacer()
                }
            }
            
            Section("Information") {
                HStack(spacing: 15) {
                    Text("Username:")
                        .foregroundColor(.gray)
                    TextField("Username", text: $usernameTextField)
                        .disabled(true)
                        .foregroundColor(.gray)
                }
                HStack(spacing: 20) {
                    Text("Full Name:")
                    TextField("Full Name", text: $fullNameTextField)
                }
                HStack {
                    Text("Description:")
                    TextField("Description", text: $descriptionTextField)
                }
            }
        }
        .navigationTitle("Edit profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button("Submit") {
                    viewModel.updateProfile(fullName: fullNameTextField, description: descriptionTextField) {
                        dismiss()
                        viewModel.fetchUserInfo() // Fetch updated user info
                    }
                }
            }
        }
        .onAppear {
            // Update the state variables with the latest data from the view model
            self.fullNameTextField = viewModel.user.fullName
            self.descriptionTextField = viewModel.user.description
            self.usernameTextField = viewModel.user.username
        }
    }
}

