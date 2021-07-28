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
    
    var parentCoordinator: PreviewContactCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let editingViewController: EditContactViewController = .instantiate()
        let editNavigationController: UINavigationController = .makeThemed()
        editNavigationController.setViewControllers([editingViewController], animated: false)
        editNavigationController.modalPresentationStyle = .fullScreen
        navigationController.present(editNavigationController, animated: true, completion: nil)
    }
    
    func onViewDidDisappear() {
        parentCoordinator?.removeChildCoordinator(self)
    }
}
