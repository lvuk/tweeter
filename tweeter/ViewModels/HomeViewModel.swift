//
//  HomeViewModel.swift
//  tweeter
//
//  Created by Luka Vuk on 22.11.2023..
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    
    init() {
        fetchTweets()
    }
    
    static let shared = HomeViewModel()
    
    func fetchTweets() {
        COLLECTION_TWEET.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            self.tweets = documents.map({Tweet(dictionary: $0.data())})
        }
    }
}
