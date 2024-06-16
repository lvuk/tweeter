//
//  NewTweetViewModel.swift
//  tweeter
//
//  Created by Luka Vuk on 21.11.2023..
//

import Foundation
import SwiftUI
import Firebase

class NewTweetViewModel: ObservableObject {
    
    func upload(caption: String) {
        guard let user = AuthViewModel.shared.user else { return }

        let newTweetRef = COLLECTION_TWEET.document() // Generate a new document reference
        let newTweetID = newTweetRef.documentID // Get the generated document ID

        let data: [String: Any] = ["uid": user.id,
                                   "caption": caption,
                                   "timestamp": Timestamp(date: Date()),
                                   "username": user.username,
                                   "profileImageUrl": user.profileImageUrl,
                                   "fullName": user.fullName,
                                   "likes": 0,
                                   "id": newTweetID]

        newTweetRef.setData(data) { error in
            if let error = error {
                print("DEBUG: Failed to upload a tweet - \(error.localizedDescription)")
                return
            }

            print("DEBUG: Successfully uploaded a tweet with ID: \(newTweetID)")
        }
    }
}
