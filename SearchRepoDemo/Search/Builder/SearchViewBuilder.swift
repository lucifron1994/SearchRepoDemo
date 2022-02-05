//
//  SearchViewBuilder.swift
//  SearchRepoDemo
//
//  Created by wanghong on 2022/02/05.
//

import UIKit

class SearchViewBuilder {
    
    static func build() -> UIViewController {
        let router = SearchViewRouter()
        let interactor = SearchViewInteractor()
        let presenter = SearchViewPresenter(interactor: interactor, router: router)
        let viewController = SearchViewController(presenter: presenter)
        router.viewController = viewController
        presenter.viewControler = viewController
        return viewController
    }
}
