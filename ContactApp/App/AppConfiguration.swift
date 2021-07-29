//
//  AppConfiguration.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation

final class AppConfiguration {
    static let shared = AppConfiguration()
    
    func setUpNetworking() {
        guard let baseURLString = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String,
              let baseURL = URL(string: baseURLString) else {
            fatalError("Base URL not found in info.plist")
        }
        
        NetworkManager.shared = NetworkManager(baseURL: baseURL)
    }
}
