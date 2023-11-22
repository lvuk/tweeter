//
//  AuthViewModel.swift
//  tweeter
//
//  Created by Luka Vuk on 14.11.2023..
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticating = false
    @Published var error: Error?
    @Published var user: User?
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to login - \(error.localizedDescription)")
                return
            }
            self.userSession = result?.user
            self.fetchUser()
            print("DEBUG: Logged in successfully..")
        }
        
    }
    
    func register(email: String, password: String, username: String, fullName: String, profileImage: UIImage?) {
        
        var image: UIImage?
        if let profileImage = profileImage {
            image = profileImage
        } else {
            image = UIImage(named: "profile-picture")!
        }
        guard let imageData = image?.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = UUID().uuidString
        let storageRef = Storage.storage().reference().child(filename)
        
        
        storageRef.putData(imageData, metadata: nil) { _ , error in
            
            
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                return
            }
            
            print("DEBUG: Successfully uploaded user photo..")
            
            
            storageRef.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in

                    if let error = error {
                        print("DEBUG: Error: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let user = result?.user else { return }
                    
                    let data = ["email": email.lowercased(),
                                "username": username.lowercased(),
                                "fullName": fullName.lowercased(),
                                "profileImageUrl": profileImageUrl,
                                "uid": user.uid
                                ]
                    
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                        self.userSession = user
                        self.fetchUser()
                        print("DEBUG: Succesfully uploaded user data..")
                    }
                }
            }
        }
    }
    
    func logout() {
        userSession = nil
        user = nil
        try? Auth.auth().signOut()
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let data = snapshot?.data() else { return }
            self.user = User(dictionary: data)
            print("DEBUG: User fetched - \(String(describing: self.user?.username))")
        }
    }
}

