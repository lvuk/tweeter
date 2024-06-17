//
//  ProfileViewModel.swift
//  tweeter
//
//  Created by Luka Vuk on 16.11.2023..
//

import Foundation
import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var isFollowed = false
    @Published var userTweets = [Tweet]()
    @Published var savedTweets = [Tweet]()
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserTweets()
        fetchUserStats()
    }
    
    func fetchUserTweets() {
        COLLECTION_TWEET.whereField("uid", isEqualTo: user.id).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.userTweets = documents.map({Tweet(dictionary: $0.data())})
            
            
        }
    }
    
    func fetchSavedTweets() {
        //TODO 
    }
    
    func fetchUserStats() {
        let followersRef = COLLECTIONS_FOLLOWERS.document(user.id).collection("user-followers")
        let followingRef = COLLECTION_FOLLOWING.document(user.id).collection("user-following")
        
        followersRef.getDocuments { snapshot, _ in
            guard let followersCount = snapshot?.documents.count else { return }
            
            followingRef.getDocuments { snapshot, _ in
                guard let followingCount = snapshot?.documents.count else { return }
                
                self.user.stats = UserStats(followers: followersCount, following: followingCount)
            }
        }
    }
    
    func follow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(user.id).setData([:]) { _ in
            COLLECTIONS_FOLLOWERS.document(self.user.id).collection("user-followers").document(currentUid).setData([:]) { _ in
                withAnimation {
                    self.isFollowed = true
                }
                print("Following....")
            }
        }
    }
    
    func unfollow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(user.id).delete { _ in
            COLLECTIONS_FOLLOWERS.document(self.user.id).collection("user-followers").document(currentUid).delete { _ in
                withAnimation {
                    self.isFollowed = false
                }
                print("Unfollowed...")
            }
        }
    }
    
    func checkIfUserIsFollowed() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(user.id).getDocument { snapshot, erorr in
            guard let isFollowed = snapshot?.exists else { return }
            self.isFollowed = isFollowed
        }
    }
}

