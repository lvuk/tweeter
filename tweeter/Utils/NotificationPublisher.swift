//
//  NotificationPublisher.swift
//  tweeter
//
//  Created by Luka Vuk on 16.06.2024..
//

import Foundation

extension Notification.Name {
    static let showDeleteDialog = Notification.Name("showDeleteDialog")
    static let hideDeleteDialog = Notification.Name("hideDeleteDialog")
}

class NotificationPublisher {
    
    static let instance = NotificationPublisher()

    func publishShowDeleteDialog() {
        NotificationCenter.default.post(name: .showDeleteDialog, object: nil)
    }

    func publishHideDeleteDialog() {
        NotificationCenter.default.post(name: .hideDeleteDialog, object: nil)
    }
}
