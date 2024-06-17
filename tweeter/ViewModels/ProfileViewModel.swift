//
//  ProfileViewModel.swift
//  tweeter
//
//  Created by Luka Vuk on 16.11.2023..
//
import Foundation
import SwiftUI
import Firebase
import Combine
import FirebaseStorage

class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var isFollowed = false
    @Published var userTweets = [Tweet]()
    @Published var savedTweets = [Tweet]()
    @Published var isLoading = true
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserInfo()
        fetchUserTweets()
        fetchUserStats()
    }
    
    func fetchUserInfo() {
        COLLECTION_USERS.document(user.id).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                DispatchQueue.main.async {
                    self.user.fullName = data?["fullName"] as? String ?? ""
                    self.user.description = data?["description"] as? String ?? ""
                    self.objectWillChange.send()
                }
            } else {
                print("User document not found")
            }
        }
    }

    func fetchUserTweets() {
        COLLECTION_TWEET.whereField("uid", isEqualTo: user.id).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.userTweets = documents.map({ Tweet(dictionary: $0.data()) })
        }
    }
    
    func fetchSavedTweets() {
        // TODO
    }
    
    func fetchUserStats() {
        let followersRef = COLLECTIONS_FOLLOWERS.document(user.id).collection("user-followers")
        let followingRef = COLLECTION_FOLLOWING.document(user.id).collection("user-following")
        
        followersRef.getDocuments { snapshot, _ in
            guard let followersCount = snapshot?.documents.count else { return }
            
            followingRef.getDocuments { snapshot, _ in
                guard let followingCount = snapshot?.documents.count else { return }
                
                DispatchQueue.main.async {
                    self.user.stats = UserStats(followers: followersCount, following: followingCount)
                    self.isLoading = false
                    self.objectWillChange.send()
                }
            }
        }
        
        print("Fetched stats...")
    }
    
    func follow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(user.id).setData([:]) { _ in
            COLLECTIONS_FOLLOWERS.document(self.user.id).collection("user-followers").document(currentUid).setData([:]) { _ in
                withAnimation {
                    self.isFollowed = true
                    self.fetchUserStats()
                }
            }
        }
    }
    
    func unfollow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(user.id).delete { _ in
            COLLECTIONS_FOLLOWERS.document(self.user.id).collection("user-followers").document(currentUid).delete { _ in
                withAnimation {
                    self.isFollowed = false
                    self.fetchUserStats()
                }
            }
        }
    }
    
    func checkIfUserIsFollowed() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(user.id).getDocument { snapshot, error in
            guard let isFollowed = snapshot?.exists else { return }
            self.isFollowed = isFollowed
        }
    }
    
//    func updateProfile(fullName: String, description: String, completion: @escaping () -> Void) {
//        let data = ["fullName": fullName,
//                    "description": description]
//        
//        COLLECTION_USERS.document(user.id).updateData(data) { [weak self] _ in
//            DispatchQueue.main.async {
//                self?.user.fullName = fullName
//                self?.user.description = description
//                self?.objectWillChange.send()
//                completion()
//            }
//        }
//    }
    
    func updateProfileImage(_ image: UIImage, completion: @escaping () -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let filename = UUID().uuidString
        let storageRef = Storage.storage().reference().child(filename)
        
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("Failed to upload image: \(error.localizedDescription)")
                return
            }
            
            storageRef.downloadURL { url, _ in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                COLLECTION_USERS.document(self.user.id).updateData(["profileImageUrl": profileImageUrl]) { _ in
                    DispatchQueue.main.async {
                        self.user.profileImageUrl = profileImageUrl
                        self.updateTweetsWithNewProfileImage(url: profileImageUrl)
                        self.objectWillChange.send()
                        completion()
                    }
                }
            }
        }
    }
    
    private func updateTweetsWithNewProfileImage(url: String) {
        COLLECTION_TWEET.whereField("uid", isEqualTo: user.id).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            for document in documents {
                var tweet = Tweet(dictionary: document.data())
                tweet.updateProfileImageUrl(url)
                
                COLLECTION_TWEET.document(tweet.id).updateData(["profileImageUrl": url])
            }
            self.fetchUserTweets()
        }
    }
    
    func updateProfile(fullName: String, description: String, completion: @escaping () -> Void) {
       let data = ["fullName": fullName,
                   "description": description]
       
       COLLECTION_USERS.document(user.id).updateData(data) { [weak self] _ in
           DispatchQueue.main.async {
               self?.user.fullName = fullName
               self?.user.description = description
               self?.updateTweetsWithNewProfileInfo(fullName: fullName)
               self?.objectWillChange.send()
               completion()
           }
       }
   }
   
   private func updateTweetsWithNewProfileInfo(fullName: String) {
       COLLECTION_TWEET.whereField("uid", isEqualTo: user.id).getDocuments { snapshot, error in
           guard let documents = snapshot?.documents else { return }
           
           for document in documents {
               let tweetId = document.documentID
               COLLECTION_TWEET.document(tweetId).updateData(["fullName": fullName])
           }
           
           // Refresh tweets in the view model
           self.fetchUserTweets()
       }
   }
}
