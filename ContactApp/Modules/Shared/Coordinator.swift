//
//  Coordinator.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
}
