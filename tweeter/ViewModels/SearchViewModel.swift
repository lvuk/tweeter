//
//  SearchViewModel.swift
//  tweeter
//
//  Created by Luka Vuk on 16.11.2023..
//

import Foundation
import SwiftUI
import Firebase
import Combine

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var filteredUsers: [User] = []
    @Published var searchText: String = "" {
        didSet {
            filterUsers()
        }
    }
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Fetch all users initially
        fetchUsers()
        
        // Observe changes to searchText and filter users accordingly
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.filterUsers()
            }
            .store(in: &cancellables)
    }
    
    static let shared = SearchViewModel()
    
    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            self.users = documents.map({User(dictionary: $0.data())})
            
            print("DEBUG: Successfully fetched users..")
        }
    }
    
    func filterUsers() {
        if searchText.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = users.filter { $0.username.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
