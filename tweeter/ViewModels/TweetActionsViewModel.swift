//
//  TweetActionsViewModel.swift
//  tweeter
//
//  Created by Luka Vuk on 15.06.2024..
//

import SwiftUI
import Firebase
import FirebaseFirestore

class TweetActionsViewModel: ObservableObject {
    let tweet: Tweet
    @Published var likes: Int
    @Published var didLike = false
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.likes = tweet.likes
        checkIfUserLikedTweet()
    }
    
//    func likeTweet() {
//        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
//            
//        let tweetLikesRef = COLLECTION_TWEET.document(tweet.id).collection("tweet-likes")
//            
//        COLLECTION_TWEET.document(tweet.id).updateData(["likes": tweet.likes + 1]) { _ in
//            COLLECTION_TWEET.document(self.tweet.id).collection("tweet-likes").document(uid).setData([:]) { _ in
//                self.didLike = true
//            }
//        }
//        
//    }
    
    func checkIfUserTweetOwner() -> Bool {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return false }
        
        return tweet.uid == uid ? true : false
    }
    
    func deleteTweet() {
        if !checkIfUserTweetOwner() {
            print("User is not a tweet owner")
            return
        }
        
        COLLECTION_TWEET.document(tweet.id).delete { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Tweet deleted!")
            }
        }
    }
    
    func checkIfUserLikedTweet() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }

        let tweetLikesRef = COLLECTION_TWEET.document(tweet.id).collection("tweet-likes").document(uid)
        
        tweetLikesRef.getDocument { document, error in
            if let error = error {
                print("Error checking if user liked tweet: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists {
                DispatchQueue.main.async {
                    self.didLike = true
                }
            }
        }
    }
    
    func likeTweet() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let tweetRef = COLLECTION_TWEET.document(tweet.id)
        let tweetLikesRef = tweetRef.collection("tweet-likes").document(uid)
        
        tweetLikesRef.setData([:]) { error in
            if let error = error {
                print("Error liking tweet: \(error.localizedDescription)")
                return
            }
            
            tweetRef.updateData(["likes": FieldValue.increment(Int64(1))]) { error in
                if let error = error {
                    print("Error updating likes: \(error.localizedDescription)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.didLike = true
                    self.likes += 1
                }
            }
        }
    }
    
    func unlikeTweet() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let tweetRef = COLLECTION_TWEET.document(tweet.id)
        let tweetLikesRef = tweetRef.collection("tweet-likes").document(uid)
        
        tweetLikesRef.delete { error in
            if let error = error {
                print("Error unliking tweet: \(error.localizedDescription)")
                return
            }
            
            tweetRef.updateData(["likes": FieldValue.increment(Int64(-1))]) { error in
                if let error = error {
                    print("Error updating likes: \(error.localizedDescription)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.didLike = false
                    self.likes -= 1
                }
            }
        }
    }
}
