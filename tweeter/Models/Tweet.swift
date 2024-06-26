//
//  Tweet.swift
//  tweeter
//
//  Created by Luka Vuk on 22.11.2023..
//

import Foundation
import Firebase

struct Tweet: Identifiable {
    
    let id: String
    let username: String
    var profileImageUrl: String
    var fullName: String
    let caption: String
    let likes: Int
    let uid: String
    let timestamp: Timestamp
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.uid = dictionary["uid"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
    
    // Method to update profile image URL
    mutating func updateProfileImageUrl(_ url: String) {
        self.profileImageUrl = url
    }
}
