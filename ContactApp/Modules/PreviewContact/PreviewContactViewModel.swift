//
//  PreviewContactViewModel.swift
//  ContactApp
//
//  Created by Mohshin on 28/7/21.
//

import Foundation

protocol PreviewContactViewModelDelegate: AnyObject {
    func updateUI()
}

final class PreviewContactViewModel {
    var coordinator: PreviewContactCoordinator?

    private(set) var contact: User {
        didSet {
            delegate?.updateUI()
        }
    }

    weak var delegate: PreviewContactViewModelDelegate?
    let isFavourite = Bool.random()
    
    init(contact: User) {
        self.contact = contact
    }
    
    deinit {
        debugPrint("Deinit PreviewContactViewModel")
    }
}

extension PreviewContactViewModel {
    func onViewDidDisappear() {
        coordinator?.onViewDidDisappear()
    }
    
    func didSelectEdit() {
        coordinator?.didSelectEdit()
    }
    
    func update(contact: User) {
        self.contact = contact
    }
}

// MARK: Presentable properties
extension PreviewContactViewModel {
    var fullName: String { contact.firstName + " " + contact.lastName }
    var avatarURL: URL { contact.avatar }
    var mobileNumber: String { "\(contact.id.value)" }
    var emailID: String { contact.email }
}
