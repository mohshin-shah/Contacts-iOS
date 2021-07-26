//
//  SceneDelegate.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        // MARK: Start of the application UI flow
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
    }
}
