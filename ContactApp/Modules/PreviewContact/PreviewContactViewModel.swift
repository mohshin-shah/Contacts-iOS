//
//  PreviewContactViewModel.swift
//  ContactApp
//
//  Created by Mohshin on 28/7/21.
//

import Foundation

final class PreviewContactViewModel {
    var coordinator: PreviewContactCoordinator?
    let contact: User
    
    init(contact: User) {
        self.contact = contact
    }
}

extension PreviewContactViewModel {
    func onViewDidDisappear() {
        coordinator?.onViewDidDisappear()
    }
}

// MARK: Presentable properties
extension PreviewContactViewModel {
    var fullName: String { contact.firstName + " " + contact.lastName }
    var avatarURL: URL { contact.avatar }
    var mobileNumber: String { "\(contact.id.value)" }
    var emailID: String { contact.email }
    var isFavourite: Bool { Bool.random() }
}
