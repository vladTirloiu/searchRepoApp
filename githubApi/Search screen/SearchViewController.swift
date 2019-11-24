//
//  ViewController.swift
//  githubApi
//
//  Created by Vlad Țîrloiu on 19/11/2019.
//  Copyright © 2019 Vlad Țîrloiu. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var fullNamesArray = Array<String>()
    var urlsArray = Array<String>()
    var forksArray = Array<Int>()
    var stargazersArray = Array<Int>()
    var watchersArray = Array<Int>()
    
    var index = Int()
    
    let searchViewModel = SearchViewModel()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func searchButtonTaped(_ sender: Any) {
        if let searchedText = searchTextField.text {
            searchViewModel.searchText(searchedText: searchedText)
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchViewModel.delegate = self
    }
}

extension SearchViewController: SearchViewModelDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func passRequestData(fullNamesArray: [String], urlsArray: [String], forksArray: [Int], stargazersArray: [Int], watchersArray: [Int]) {
        if self.fullNamesArray.first != nil {
            self.fullNamesArray.removeAll()
            self.urlsArray.removeAll()
            self.forksArray.removeAll()
            self.stargazersArray.removeAll()
            self.watchersArray.removeAll()
        }
        self.fullNamesArray = fullNamesArray
        self.urlsArray = urlsArray
        self.forksArray = forksArray
        self.stargazersArray = stargazersArray
        self.watchersArray = watchersArray
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fullNamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                
        let desplayedString = fullNamesArray[indexPath.row]
        cell.textLabel?.text = desplayedString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        index = indexPath.row
        showDetailsVC()
    }
    
    func showGeneralError(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: .none, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func showDetailsVC() {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let vc = mainStoryboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.fullName = fullNamesArray[index]
        vc.url = urlsArray[index]
        vc.forks = forksArray[index]
        vc.stargazers = stargazersArray[index]
        vc.watchers = watchersArray[index]
        present(vc, animated: true, completion: nil)
        
    }
}
