//
//  ContactListCoordinator.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation
import UIKit

final class ContactListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let contactListViewController: ContactListViewController = .instantiate()
        let viewModel = ContactListViewModel(delegate: contactListViewController)
        viewModel.coordinator = self
        contactListViewController.viewModel = viewModel
        navigationController.setViewControllers([contactListViewController], animated: false)        
    }
    
    func onSelect(contact: User) {
        // PreviewContactCoordinator
        let previewContactCoordinator = PreviewContactCoordinator(
            contact: contact,
            navigationController: navigationController
        )
        previewContactCoordinator.parentCoordinator = self
                
        childCoordinators.append(previewContactCoordinator)        
        previewContactCoordinator.start()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = (childCoordinators.firstIndex(where: { $0 === coordinator })) {
            childCoordinators.remove(at: index)
        }
    }
}
