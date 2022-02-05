//
//  SearchViewPresenter.swift
//  SearchRepoDemo
//
//  Created by wanghong on 2022/02/05.
//

import Foundation
import UIKit
import Combine

class SearchViewPresenter: SearchViewPresenterType {
    
    weak var viewControler: UIViewController?
    private let interactor: SearchViewInteractorType
    private let router: SearchViewRouter
    private var model: SearchResultListModel? = nil {
        didSet {
            listModelDidChangedPublisher.send(model)
        }
    }
    var listModelDidChangedPublisher = PassthroughSubject<SearchResultListModel?, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: SearchViewInteractorType, router: SearchViewRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func numberOfItem() -> Int {
        let result = self.model?.items.count ?? 0
        return result
    }
    
    func item(at index: Int) -> SearchResultModel {
        guard let models = model?.items, index < models.count else {
            fatalError("")
        }
        return models[index]
    }
    
    func search(keyword: String) {
        interactor.searchRequest(keyword: keyword).sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.displayErrorAlert(error: error)
            }
        } receiveValue: {[weak self] model in
            self?.model = model
        }.store(in: &cancellables)
    }
    
    func setupInput(input: SearchViewPresenterInput) {
        input.search.debounce(for: .milliseconds(300), scheduler: RunLoop.main).removeDuplicates().sink { [weak self] searchText in
            self?.search(keyword: searchText)
        }.store(in: &cancellables)
    }

    func displayErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Error Occurred😭", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewControler?.present(alert, animated: true, completion: nil)
    }
}
