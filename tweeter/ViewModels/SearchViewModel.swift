//
//  SearchViewModel.swift
//  tweeter
//
//  Created by Luka Vuk on 16.11.2023..
//

import Foundation
import SwiftUI
import Firebase

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    static let shared = SearchViewModel()
    
    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            self.users = documents.map({User(dictionary: $0.data())})
            
            print("DEBUG: Successfully fetched users..")
        }
    }
}
