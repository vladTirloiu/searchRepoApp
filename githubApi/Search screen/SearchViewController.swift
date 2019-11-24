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
    
    var constant = Int()
    
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
        
//        tableView.dataSource = self
//        tableView.delegate = self
    }
    
    

}

extension SearchViewController: SearchViewModelDelegate, UITableViewDelegate, UITableViewDataSource {
 
    func passFullNameArray(array: [String]) {
        if reposNamesArray.first != nil {
            reposNamesArray.removeAll()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        constant = indexPath.row
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
        vc.fullName = reposNamesArray[constant]
        present(vc, animated: true, completion: nil)
        
    }
}
