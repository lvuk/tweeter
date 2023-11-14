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

class AuthViewModel: ObservableObject {
    
    func login() {
        
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
                    
                    let data = ["email": email,
                                "username": username,
                                "fullName": fullName,
                                "profileImageUrl": profileImageUrl,
                                "uid": user.uid
                                ]
                    
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                        print("DEBUG: Succesfully uploaded user data..")
                        
                    }
                }
            }
        }
    }
}

