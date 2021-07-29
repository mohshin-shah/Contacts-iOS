//
//  ContactListViewModelTests.swift
//  ContactAppTests
//
//  Created by Mohshin on 29/7/21.
//

import XCTest
@testable import ContactApp

class ContactListViewModelTests: XCTestCase {
    
    func testLoadData() {
        let exp = expectation(description: "ListDataLoading")        
        let sut = makeSUT()
        
        let binder = ViewModelHandler { isSuccess in
            guard isSuccess else { return }
            exp.fulfill()
        }
        
        sut.delegate = binder
        sut.loadData()
        wait(for: [exp], timeout: 1.0)
        XCTAssert(sut.numberOfContacts() == 6)
    }
}

extension ContactListViewModelTests {
    private func makeSUT() -> ContactListViewModel {
        ContactListViewModel(userWebService: MockNetworkManager.shared)
    }
}

private class ViewModelHandler: ContactListViewModelDelegate {
    var completion: ((Bool) -> Void)?
    init(callBack: @escaping (Bool) -> Void) {
        self.completion = callBack
    }    
}

