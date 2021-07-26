//
//  AppCoordinator.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        
        let contactListCoordinator = ContactListCoordinator(navigationController: navigationController)
        childCoordinators.append(contactListCoordinator)
        
        contactListCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
}
