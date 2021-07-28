//
//  EditContactCoordinator.swift
//  ContactApp
//
//  Created by Mohshin on 28/7/21.
//

import Foundation
import UIKit

final class EditContactCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let contact: User
    
    var parentCoordinator: PreviewContactCoordinator?
    
    init(
        contact: User,
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
        self.contact = contact
    }
    
    func start() {
        let editContactViewModel = EditContactViewModel(contact: contact)
        editContactViewModel.coordinator = self
        
        let editingViewController: EditContactViewController = .instantiate()
        editingViewController.viewModel = editContactViewModel
        
        let editNavigationController: UINavigationController = .makeThemed()
        editNavigationController.setViewControllers([editingViewController], animated: false)
        editNavigationController.modalPresentationStyle = .fullScreen
        navigationController.present(editNavigationController, animated: true, completion: nil)
    }
    
    func onViewDidDisappear() {
        parentCoordinator?.removeChildCoordinator(self)
    }
}
