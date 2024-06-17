//
//  SettingsView.swift
//  tweeter
//
//  Created by Luka Vuk on 17.06.2024..
//

import SwiftUI

struct SettingsView: View {
    @State private var isShowingLogout = false
    var body: some View {
        List {
            Section {
                Button("Logout", role: .destructive) { isShowingLogout.toggle() }
            }
        }
        .confirmationDialog("Are you sure you want to logout", isPresented: $isShowingLogout) {
            Button("Logout", role: .destructive) {
                AuthViewModel.shared.logout()
            }
            Button("Cancel", role: .cancel) { }
        }
    }
}

#Preview {
    SettingsView()
}
