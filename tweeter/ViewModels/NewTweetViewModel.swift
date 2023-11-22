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
        
        let data: [String: Any] = ["uid": user.id,
                                   "caption": caption,
                                   "timestamp": Timestamp(date: Date()),
                                   "username": user.username,
                                   "profileImageUrl": user.profileImageUrl,
                                   "fullName": user.fullName,
                                   "likes": 0,
                                   "id": COLLECTION_TWEET.document().documentID]
        
        COLLECTION_TWEET.document().setData(data) { [weak self] error in
            if let error = error {
                print("DEBUG: Failed to upload a tweet..")
                return
            }
            
            print("DEBUG: Successfully uploaded a tweet..")
        }
    }
}
