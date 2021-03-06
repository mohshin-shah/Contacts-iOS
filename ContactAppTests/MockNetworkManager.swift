//
//  MockNetworkManager.swift
//  ContactAppTests
//
//  Created by Mohshin on 26/7/21.
//

import Foundation
@testable import ContactApp
import Promises

final class MockNetworkManager {
    static let shared = MockNetworkManager()
}

// Mock implementation of UserWebService for testing
extension MockNetworkManager: UserWebService {
    func updateUser(with id: Identifier<User>, newUser: User) -> Promise<Void> {
        fatalError("Unimplemented")
    }
    
    func getAllUsers(pageNumber: Int, itemsPerPage: Int) -> Promise<[User]> {
        Promise { f, _ in
            let apiResponse = try Bundle.main.decode(Response<[User]>.self, from: "users.json")
            f(apiResponse.data)
        }
    }
}
