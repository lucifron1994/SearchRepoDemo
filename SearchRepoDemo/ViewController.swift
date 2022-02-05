//
//  ViewController.swift
//  SearchRepoDemo
//
//  Created by wanghong on 2022/02/05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showSearchViewButtonTapped(_ sender: Any) {
        let vc = SearchViewBuilder.build()
        self.navigationController?.show(vc, sender: nil)
    }
}

