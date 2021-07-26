//
//  NetworkManager.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation

final class NetworkManager {
    public static var shared: NetworkManager {
        get {
            guard let _shared = _shared else {
                fatalError("NetworkManager.shared is nil! Please configure it before accessing.")
            }
            return _shared
        }
        set { _shared = newValue }
    }
    
    private static var _shared: NetworkManager?
    
    let defaultBaseURL: URL
    
    init(baseURL: URL) {
        self.defaultBaseURL = baseURL
        configureWebServiceEndPoints()
    }
    
    private func configureWebServiceEndPoints() {
        UserWebServiceEndpoint.baseURL = defaultBaseURL
    }
}
