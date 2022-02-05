//
//  SearchViewInteractorTest.swift
//  SearchRepoDemoTests
//
//  Created by wanghong on 2022/02/05.
//

import XCTest
@testable import SearchRepoDemo
import Combine

class SearchViewInteractorTest: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    let interactor = SearchViewInteractor()

    func testSearchText() {
        let expectation = expectation(description: "SearchViewInteractorTest_testSearchText")
        interactor.searchRequest(keyword: "Apple").sink { completion in
        } receiveValue: { value in
            expectation.fulfill()
        }.store(in: &cancellables)
        self.waitForExpectations(timeout: 3.0, handler: nil)
    }
}
