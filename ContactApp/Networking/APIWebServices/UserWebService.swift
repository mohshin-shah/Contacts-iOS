//
//  WebServices.swift
//  ContactApp
//
//  Created by Mohshin on 26/7/21.
//

import Foundation
import Alamofire

public protocol UserWebService: AnyObject {}

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
