//
//  SearchViewInteractor.swift
//  SearchRepoDemo
//
//  Created by wanghong on 2022/02/05.
//

import Foundation
import Combine

class SearchViewInteractor: SearchViewInteractorType {
    func searchRequest(keyword: String) -> AnyPublisher<SearchResultListModel, RequestError> {
        let param = ["q": keyword]
        return RequestManager.shard.request(path: Config.searchRepositoriesPath, responseModelType: SearchResultListModel.self, param: param)
    }
}
