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
        //TODO: Show ContactListViewController from here
    }
}
