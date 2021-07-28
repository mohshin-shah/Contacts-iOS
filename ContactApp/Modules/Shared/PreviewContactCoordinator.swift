//
//  PreviewContactCoordinator.swift
//  ContactApp
//
//  Created by Mohshin on 27/7/21.
//

import Foundation
import UIKit

final class PreviewContactCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let contact: User
    private let navigationController: UINavigationController
    
    var parentCoordinator: ContactListCoordinator?
    
    init(
        contact: User,
        navigationController: UINavigationController
    ) {
        self.contact = contact
        self.navigationController = navigationController
    }
    
    func start() {
        let previewController: PreviewContactViewController = .instantiate()
        // PreviewContactViewModel
        let previewContactViewModel = PreviewContactViewModel(contact: contact)
        previewContactViewModel.coordinator = self
        previewController.viewModel = previewContactViewModel

        navigationController.pushViewController(previewController, animated: true)
    }
    
    func onViewDidDisappear() {
        parentCoordinator?.removeChildCoordinator(self)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = (childCoordinators.firstIndex(where: { $0 === coordinator })) {
            childCoordinators.remove(at: index)
        }
    }
    
    func didSelectEdit() {
        let editContactCoordinator = EditContactCoordinator(navigationController: navigationController)
        editContactCoordinator.parentCoordinator = self
        childCoordinators.append(editContactCoordinator)
        editContactCoordinator.start()
    }
    
    deinit {
        debugPrint("Deinit PreviewContactCoordinator")
    }
}
