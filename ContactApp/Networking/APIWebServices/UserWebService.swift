//
//  WebServices.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation
import Alamofire
import Promises

protocol UserWebService: AnyObject {
    func getAllUsers(pageNumber: Int, itemsPerPage: Int) -> Promise<[User]>
}

enum UserWebServiceEndpoint {
    case listUsers(pageNumber: Int, itemsPerPage: Int)
}

extension UserWebServiceEndpoint: Endpoint {
    static var baseURL: URL?
    
    var path: String {
        switch self {
        case let .listUsers(pageNumber, itemsPerPage):
            return "/users?page=\(pageNumber)&per_page=\(itemsPerPage)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .listUsers: return .get
        }
    }
}

// MARK: UserWebService network implmentaion
extension NetworkManager: UserWebService {
    func getAllUsers(pageNumber: Int, itemsPerPage: Int) -> Promise<[User]> {
        requestDecodable(
            UserWebServiceEndpoint.listUsers(pageNumber: pageNumber, itemsPerPage: itemsPerPage)
        )
    }
}
