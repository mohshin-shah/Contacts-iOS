//
//  EditContactViewModel.swift
//  ContactApp
//
//  Created by Mohshin on 28/7/21.
//

import Foundation

protocol EditContactViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: EditContactViewModel, didInputInvalidDataForField inputField: String)
    func viewModelDidFinishEditingWithSuccess(_ viewModel: EditContactViewModel, message: String?)
    func viewModel(_ viewModel: EditContactViewModel, didFinishEditingWithError error: EditContactError)
}

enum EditContactError: Error {
    case invalidInput(message: String)
    case failedToUpdate(message: String)
}

final class EditContactViewModel {
    let contact: User
    var coordinator: EditContactCoordinator?
    weak var delegate: EditContactViewModelDelegate?
    let avatarURL: URL
    
    var firstName: String? {
        didSet {
            validateString(with: firstName, inputName: "first name")
        }
    }
    
    var lastName: String? {
        didSet {
            validateString(with: lastName, inputName: "last name")
        }
    }
    
    var mobileNumber: String? {
        didSet {
            validateString(with: mobileNumber)
        }
    }
    
    var emailID: String? {
        didSet {
            validateString(with: emailID)
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
    private func validateString(with value: String?, inputName: String = "") {
        guard value.isNilOrEmpty else {
            return
        }
        let message = "Invalid \(inputName). Please enter a valid value"
        delegate?.viewModel(self, didFinishEditingWithError: .invalidInput(message: message))
    }
    
    // TODO: Validates if the string is a valid email address
    private func validateEmail(with value: String?) {
        guard value.isNilOrEmpty else {
            return
        }
        let message = "Invalid input. Please enter a valid value"
        delegate?.viewModel(self, didFinishEditingWithError: .invalidInput(message: message))
    }
    
    deinit {
        debugPrint("Deinit EditContactViewModel")
    }
}

extension EditContactViewModel {
    
    func onViewDidDisappear() {
        coordinator?.onViewDidDisappear()
    }

    func updateContact() {
        let isEmptyInputData =
            firstName.isNilOrEmpty ||
            lastName.isNilOrEmpty ||
            mobileNumber.isNilOrEmpty ||
            emailID.isNilOrEmpty
        
        guard !isEmptyInputData else {
            let message = "Please input valid input data"
            delegate?.viewModel(self, didFinishEditingWithError: EditContactError.invalidInput(message: message))
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
                guard let self = self else { return }
                self.coordinator?.didUpdate(contact: newUser)
                self.delegate?.viewModelDidFinishEditingWithSuccess(self, message: "Updated successfully")
            }.catch { [weak self] in
                guard let self = self else { return }
                self.delegate?.viewModel(self, didFinishEditingWithError: .failedToUpdate(message: $0.localizedDescription))
            }
    }
}
