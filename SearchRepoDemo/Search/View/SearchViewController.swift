//
//  SearchViewController.swift
//  SearchRepoDemo
//
//  Created by wanghong on 2022/02/05.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let presenter: SearchViewPresenterType
    private let tableViewDataSource: UITableViewDataSource
    
    private let searchPublisher = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init(presenter: SearchViewPresenterType) {
        self.presenter = presenter
        self.tableViewDataSource = SearchViewResultTableViewDataSource(presenter: presenter)
        super.init(nibName: "SearchViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup Delegate/DataSource
        self.searchBar.delegate = self
        self.tableView.dataSource = self.tableViewDataSource
        
        // Setup SearchViewPresenter
        let presenterInput = SearchViewPresenterInput(search: searchPublisher.eraseToAnyPublisher())
        presenter.setupInput(input: presenterInput)
        presenter.listModelDidChangedPublisher.sink { [weak self] _ in
            self?.tableView.reloadData()
        }.store(in: &cancellables)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchPublisher.send(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchPublisher.send(searchText)
    }
}
