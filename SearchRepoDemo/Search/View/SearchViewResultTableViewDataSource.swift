//
//  SearchViewResultTableViewDataSource.swift
//  SearchRepoDemo
//
//  Created by wanghong on 2022/02/05.
//

import Foundation
import UIKit

class SearchViewResultTableViewDataSource: NSObject, UITableViewDataSource {
    
    private let kSearchResultCellReuseId = "SearchViewResultTableViewCellReuseId"
    private let presenter: SearchViewPresenterType
    
    init(presenter: SearchViewPresenterType) {
        self.presenter = presenter
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItem()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kSearchResultCellReuseId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: kSearchResultCellReuseId)
        }
        let model = presenter.item(at: indexPath.row)
        cell?.textLabel?.text = model.name
        return cell ?? UITableViewCell()
    }
}
