//
//  User.swift
//  tweeter
//
//  Created by Luka Vuk on 16.11.2023..
//

import Foundation
import Firebase

struct User: Identifiable {
    let id: String
    let username: String
    let email: String
    let profileImageUrl: String
    let fullName: String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == self.id }
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
    }
    
    init(id: String, username: String, email: String, profileImageUrl: String, fullName: String) {
        self.id = id
        self.username = username
        self.email = email
        self.profileImageUrl = profileImageUrl
        self.fullName = fullName
    }
    
    static let example = User(id: "blabla", username: "vuk", email: "luka@Vuk.com", profileImageUrl: "blabla.com", fullName: "Luka Vuk")
}
