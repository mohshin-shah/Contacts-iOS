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
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let previewController: PreviewContactViewController = .instantiate()
        navigationController.pushViewController(previewController, animated: true)
    }
}
