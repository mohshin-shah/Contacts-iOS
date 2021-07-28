//
//  UIViewController+Extensions.swift
//  ContactApp
//
//  Created by Mohshin on 28/7/21.
//

import Foundation
import UIKit

extension UIStoryboard {
    static let main: UIStoryboard = UIStoryboard(name: "Main", bundle: .main)
}

extension UIViewController {
    static func instantiate<T: UIViewController>(from storyboard: UIStoryboard = .main) -> T {
        storyboard.instantiateViewController(identifier: "\(T.self)") as! T
    }
}

extension UINavigationController {
    static func makeThemed() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.view.tintColor = .primary
        navigationController.navigationBar.backgroundColor = .white
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }
}
