//
//  EditContactViewModel.swift
//  ContactApp
//
//  Created by Mohshin on 28/7/21.
//

import Foundation

protocol EditContactViewModelDelegate: AnyObject {
    func showError(message: String)
    func showSuccess(message: String)
}

final class EditContactViewModel {
    let contact: User
    var coordinator: EditContactCoordinator?
    weak var delegate: EditContactViewModelDelegate?
    let avatarURL: URL
    
    var firstName: String? {
        didSet {
            validateString(with: firstName)
        }
    }
    
    var lastName: String? {
        didSet {
            validateString(with: firstName)
        }
    }
    
    var mobileNumber: String? {
        didSet {
            validateString(with: firstName)
        }
    }
    
    var emailID: String? {
        didSet {
            validateString(with: firstName)
        }
    }

    init(contact: User) {
        self.contact = contact
        avatarURL = contact.avatar
        firstName = contact.firstName
        lastName = contact.lastName
        mobileNumber = "\(contact.id.value)"
        emailID = contact.email
    }
    
    // Validates if the string is empty
    private func validateString(with value: String?) {
        guard value.isNilOrEmpty else {
            return
        }
        delegate?.showError(message: "Invalid input. Please enter a valid value")
    }
    
    // TODO: Validates if the string is a valid email address
    private func validateEmail(with value: String?) {
        guard value.isNilOrEmpty else {
            return
        }
        delegate?.showError(message: "Invalid input. Please enter a valid value")
    }
}

extension EditContactViewModel {
    
    func onViewDidDisappear() {
        coordinator?.onViewDidDisappear()
    }

    func updateContact() {
        let isEmptyInputData =
            firstName.isNilOrEmpty &&
            lastName.isNilOrEmpty &&
            mobileNumber.isNilOrEmpty &&
            emailID.isNilOrEmpty
        
        guard !isEmptyInputData else {
            delegate?.showError(message: "Please input valid input data")
            return
        }
        
        // Updated User
        let newUser = User(
            id: contact.id,
            avatar: contact.avatar,
            email: contact.email,
            firstName: firstName ?? contact.firstName,
            lastName: lastName ?? contact.lastName
        )
        
        NetworkManager.shared
            .updateUser(with: contact.id, newUser: newUser)
            .then { [weak self] in
                self?.delegate?.showSuccess(message: "Saved succesfully")
            }.catch { [weak self] in
                self?.delegate?.showError(message: $0.localizedDescription)
            }
    }
}
