//
//  ViewController.swift
//  githubApi
//
//  Created by Vlad Țîrloiu on 19/11/2019.
//  Copyright © 2019 Vlad Țîrloiu. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchViewModel = SearchViewModel()

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func searchButtonTaped(_ sender: Any) {
        if let searchedText = searchTextField.text {
            searchViewModel.searchText(searchedText: searchedText)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchViewModel.delegate = self
    }


}

extension SearchViewController: SearchViewModelDelegate {
    
    func showGeneralError(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: .none, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
