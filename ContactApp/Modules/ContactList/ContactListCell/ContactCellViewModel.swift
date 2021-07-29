//
//  ContactCellViewModel.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation

final class ContactCellViewModel {
    let contact: User
    var onSelect: ((User) -> Void)?
    
    init(contact: User, onSelect: ((User) -> Void)? = nil) {
        self.contact = contact
        self.onSelect = onSelect
    }
    
    func didSelect() {
        onSelect?(contact)
    }
}

// MARK: Presentable properties
extension ContactCellViewModel {
    var fullName: String { contact.firstName + " " + contact.lastName }
    var avatarURL: URL { contact.avatar }
}
