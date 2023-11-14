//
//  tweeterApp.swift
//  tweeter
//
//  Created by Luka Vuk on 02.11.2023..
//

import SwiftUI
import Firebase

@main
struct tweeterApp: App {
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            LoginView()
        }
    }
}
