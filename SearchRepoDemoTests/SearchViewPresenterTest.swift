//
//  SearchViewPresenterTest.swift
//  SearchRepoDemoTests
//
//  Created by wanghong on 2022/02/05.
//

import XCTest
@testable import SearchRepoDemo
import Combine

class SearchViewPresenterTest: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    let router = SearchViewRouter()
    let interactor = TestSearchViewInteractor()
    lazy var presenter = SearchViewPresenter(interactor: interactor, router: router)
    
    func testListModelDidChangedPublisher() {
        let expectation = expectation(description: "SearchViewPresenterTest_testListModelDidChangedPublisher")
        presenter.listModelDidChangedPublisher.sink { [weak self] models in
            if let model = models {
                weak var weakPresenter = self?.presenter
                XCTAssertEqual(model.items.count, weakPresenter?.numberOfItem())
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        presenter.search(keyword: "Swift")
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    class TestSearchViewInteractor: SearchViewInteractorType {
        let testSearchResultListModel = SearchResultListModel(items: [SearchResultModel(name: "test")])
        func searchRequest(keyword: String) -> AnyPublisher<SearchResultListModel, RequestError> {
            return Future<SearchResultListModel, RequestError> { promise in
                promise(.success(self.testSearchResultListModel))
            }.eraseToAnyPublisher()
        }
    }
}
