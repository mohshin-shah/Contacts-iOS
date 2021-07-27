//
//  ContactListViewModel.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation

protocol ContactListViewModelDelegate: AnyObject {
    func updateListUI()
    func showErrorUI(with errorMessage: String)
}

final class ContactListViewModel {
        
    weak var delegate: ContactListViewModelDelegate?
    var coordinator: ContactListCoordinator?
    
    private var currentPage = 1
    private var contactCellViewModels: [ContactCellViewModel] = []
    private let itemsPerPage = 10
    
    init(delegate: ContactListViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    func loadData(for page: Int? = nil) {
        currentPage = page ?? 1
        NetworkManager.shared
            .getAllUsers(pageNumber: currentPage, itemsPerPage: itemsPerPage)
            .then(handleSuccess)
            .catch(handleError)
            
    }
    
    private func handleSuccess(_ users: [User]) {
        contactCellViewModels = users.map(ContactCellViewModel.init)
        delegate?.updateListUI()
    }
    
    private func handleError(_ error: Error) {
        delegate?.showErrorUI(with: error.localizedDescription)
    }
}

extension ContactListViewModel {
    var title: String { "Contact" }
    
    func onAddContact() {
        coordinator?.startAddContact( )
    }
    
    func numberOfContacts() -> Int { contactCellViewModels.count }
    
    func contactCellViewModelAt(indexPath: IndexPath) -> ContactCellViewModel? {
        guard contactCellViewModels.count > indexPath.row else { return nil }
        return contactCellViewModels[indexPath.row]
    }
}
