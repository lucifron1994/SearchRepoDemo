//
//  SearchViewInteractorType.swift
//  SearchRepoDemo
//
//  Created by wanghong on 2022/02/05.
//

import Foundation
import Combine

protocol SearchViewInteractorType: AnyObject {
    func searchRequest(keyword: String) -> AnyPublisher<SearchResultListModel, RequestError>
}
