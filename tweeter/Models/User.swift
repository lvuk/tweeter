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
    var profileImageUrl: String
    var fullName: String
    var description: String
    var stats: UserStats
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == self.id }
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.stats = UserStats(followers: 0, following: 0)
    }
}

struct UserStats {
    let followers: Int
    let following: Int
}
