//
//  Constants.swift
//  tweeter
//
//  Created by Luka Vuk on 16.11.2023..
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTIONS_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_TWEET = Firestore.firestore().collection("tweets")
