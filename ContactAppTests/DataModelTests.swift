//
//  ContactAppTests.swift
//  ContactAppTests
//
//  Created by Mohshin on 26/7/21.
//

@testable import ContactApp
import XCTest
import Promises

class DataModelTests: XCTestCase {

    func testUserModelDecoding_using_mockWebService() throws {
        var users: [User] = []
        
        let decodingExpectation = expectation(description: "ModelDecoding")
        
        MockNetworkManager.shared
            .getAllUsers(pageNumber: 1, itemsPerPage: 6)
            .then { _users in
                users = _users
                decodingExpectation.fulfill()
            }
            .catch { error in
                XCTFail(error.localizedDescription)
            }
        
        wait(for: [decodingExpectation], timeout: 1.0)
        
        XCTAssertTrue(users.count == 6)
        
        let firstUser = try XCTUnwrap(users.first)
        XCTAssertTrue(firstUser.id.value == 7)
        XCTAssertTrue(firstUser.firstName == "Michael")
        XCTAssertTrue(firstUser.lastName == "Lawson")
        XCTAssertTrue(firstUser.email == "michael.lawson@reqres.in")
    }
}
