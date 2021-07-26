//
//  ContactCellViewModel.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation

final class ContactCellViewModel {
    let contact: User
    
    init(contact: User) {
        self.contact = contact
    }
}

// MARK: Presentable properties
extension ContactCellViewModel {
    var fullName: String { contact.firstName + " " + contact.lastName }
    var avatarURL: URL { contact.avatar }
}
