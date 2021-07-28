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
    func updateUser(with id: Identifier<User>, newUser: User) -> Promise<Void>
}

enum UserWebServiceEndpoint {
    case listUsers(pageNumber: Int, itemsPerPage: Int)
    case update(id: Identifier<User>, newUser: User)
}

extension UserWebServiceEndpoint: Endpoint {
    static var baseURL: URL?
    
    var path: String {
        switch self {
        case let .listUsers(pageNumber, itemsPerPage):
            return "/api/users?page=\(pageNumber)&per_page=\(itemsPerPage)"
        case let .update(id, _):
            return "/api/users/\(id.value)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .listUsers: return .get
        case .update: return .put
        }
    }
    
    var parameter: RequestParameterEncodable? {
        switch self {
        case let .update(_, newUser):
            return JSONParameter(parameters: [
                "first_name": newUser.firstName,
                "last_name": newUser.lastName,
            ])
        default:
            return nil
        }
    }
}

// MARK: UserWebService network implmentaion
extension NetworkManager: UserWebService {
    func getAllUsers(pageNumber: Int, itemsPerPage: Int) -> Promise<[User]> {
        let responsePromise: Promise<Response<[User]>>
            = requestDecodable(
                UserWebServiceEndpoint.listUsers(pageNumber: pageNumber, itemsPerPage: itemsPerPage)
            )
        return responsePromise.then { $0.data }
    }
    
    func updateUser(with id: Identifier<User>, newUser: User) -> Promise<Void> {
        request(UserWebServiceEndpoint.update(id: id, newUser: newUser))
    }
}
