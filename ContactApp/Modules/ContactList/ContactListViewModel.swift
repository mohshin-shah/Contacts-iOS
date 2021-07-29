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
    private let userWebService: UserWebService
    
    init(
        delegate: ContactListViewModelDelegate? = nil,
        userWebService: UserWebService = NetworkManager.shared
    ) {
        self.userWebService = userWebService
        self.delegate = delegate
    }
    
    func loadData(for page: Int? = nil) {
        currentPage = page ?? 1
        userWebService
            .getAllUsers(pageNumber: currentPage, itemsPerPage: itemsPerPage)
            .then(handleSuccess)
            .catch(handleError)
            
    }
    
    private func handleSuccess(_ users: [User]) {
        let sortedUsers = users.sorted { $0.firstName < $1.firstName }
        contactCellViewModels = sortedUsers.map(makeCellViewModel)
        delegate?.updateListUI()
    }
    
    private func makeCellViewModel(with contact: User) -> ContactCellViewModel {
        ContactCellViewModel(contact: contact) { [weak self] dataModel in
            self?.coordinator?.onSelect(contact: dataModel)
        }
    }
    
    private func handleError(_ error: Error) {
        delegate?.showErrorUI(with: error.localizedDescription)
    }
}

extension ContactListViewModel {
    var title: String { "Contact" }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let contactCellVM = contactCellViewModelAt(indexPath: indexPath) else { return }
        contactCellVM.didSelect()
    }
    
    func numberOfContacts() -> Int { contactCellViewModels.count }
    
    func contactCellViewModelAt(indexPath: IndexPath) -> ContactCellViewModel? {
        guard contactCellViewModels.count > indexPath.row else { return nil }
        return contactCellViewModels[indexPath.row]
    }
    
    func update(contact: User) {
        guard let index = contactCellViewModels.firstIndex(where: { $0.contact.id.value == contact.id.value }) else { return }
        let newCellViewModel = makeCellViewModel(with: contact)
        contactCellViewModels[index] = newCellViewModel
        delegate?.updateListUI()
    }
}
