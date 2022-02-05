//
//  SearchResultModel.swift
//  SearchRepoDemo
//
//  Created by wanghong on 2022/02/05.
//

import Foundation

class SearchResultModel: Decodable {
    let name: String
    
    init (name: String) {
        self.name = name
    }
}
