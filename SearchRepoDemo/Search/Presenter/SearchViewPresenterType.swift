//
//  SearchViewPresenterType.swift
//  SearchRepoDemo
//
//  Created by wanghong on 2022/02/05.
//

import Foundation
import Combine

struct SearchViewPresenterInput {
    let search: AnyPublisher<String, Never>
}

protocol SearchViewPresenterType: AnyObject {
    func numberOfItem() -> Int
    func item(at index: Int) -> SearchResultModel
    func search(keyword: String)
    func setupInput(input: SearchViewPresenterInput)
    var listModelDidChangedPublisher: PassthroughSubject<SearchResultListModel?, Never> { get }
}
