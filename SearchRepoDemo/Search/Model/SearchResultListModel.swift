//
//  SearchResultListModel.swift
//  SearchRepoDemo
//
//  Created by wanghong on 2022/02/05.
//

import Foundation

class SearchResultListModel: Decodable {
    let items: [SearchResultModel]
    
    init (items: [SearchResultModel]) {
        self.items = items
    }
}
