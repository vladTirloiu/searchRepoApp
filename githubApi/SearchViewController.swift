//
//  ViewController.swift
//  githubApi
//
//  Created by Vlad Țîrloiu on 19/11/2019.
//  Copyright © 2019 Vlad Țîrloiu. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var reposNamesArray = Array<String>()
    
    let searchViewModel = SearchViewModel()

    @IBOutlet weak var tableView: UITableView!
    
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
        
        tableView.dataSource = self
        tableView.delegate = self
    }


}

extension SearchViewController: SearchViewModelDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func passFullNameArray(array: [String]) {
        reposNamesArray = array
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposNamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                
        let desplayedString = reposNamesArray[indexPath.row]
        cell.textLabel?.text = desplayedString
        
        return cell
    }
    
    
    func showGeneralError(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: .none, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
