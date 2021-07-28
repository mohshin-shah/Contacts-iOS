//
//  EditContactViewModel.swift
//  ContactApp
//
//  Created by Mohshin on 28/7/21.
//

import Foundation

final class EditContactViewModel {
    let contact: User
    
    var coordinator: EditContactCoordinator?
    
    init(contact: User) {
        self.contact = contact
    }
}
