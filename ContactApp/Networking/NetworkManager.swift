//
//  NetworkManager.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Alamofire
import Foundation
import Promises

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
    let apiSession = Session.default
    
    init(baseURL: URL) {
        self.defaultBaseURL = baseURL
        configureWebServiceEndPoints()
    }
    
    private func configureWebServiceEndPoints() {
        UserWebServiceEndpoint.baseURL = defaultBaseURL
    }
}

// MARK: - Requests
extension NetworkManager {
    /// Returns a promise that requests `Decodable` value at the specified API endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The endpoint for the request.
    ///   - decoder: A JSONDecoder to decode the response data into value.
    func requestDecodable<T>(_ endpoint: Endpoint, decoder: JSONDecoder = JSONDecoder()) -> Promise<T> where T: Decodable {
        Promise(on: .global()) { fulfill, reject in
            let request = self.apiSession.request(endpoint)
            request.validate().responseDecodable(decoder: decoder) { (response: AFDataResponse<T>) in
                response.resolve(fulfill, reject)
            }
        }
    }
}

private extension DataResponse {
    func resolve(_ fulfill: (Success) -> Void, _ reject: (Error) -> Void) {
        switch result {
        case let .success(value):
            fulfill(value)
        case let .failure(error):
            reject(error)
        }
    }
}
