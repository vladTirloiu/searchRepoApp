//
//  DetailsViewController.swift
//  githubApi
//
//  Created by Vlad Țîrloiu on 22/11/2019.
//  Copyright © 2019 Vlad Țîrloiu. All rights reserved.
//

import UIKit

class DetailsViewController: SearchViewController {
    
    let detailsViewModel = DetailsViewModel()
    
    var fullName = String()
    var url = String()
    var stargazers = Int()
    var forks = Int()
    var watchers = Int()
    var readme = String()
    
    @IBOutlet weak var referanceView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        var ownerName = String()
        var repoName = String()
        
        let splittedRepoName = fullName.split(separator: "/")
        
        if let firstString = splittedRepoName.first {
            ownerName = "\(String(describing: firstString))"
        }
        if let secondString = splittedRepoName.last {
            repoName = "\(String(describing: secondString))"
        }

        detailsViewModel.readmeRequest(ownerName: ownerName, repoName: repoName)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailsViewModel.delegate = self
        
        textView.text = ""
        
        let scrollView: UIScrollView = {
            let v = UIScrollView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = .cyan
            return v
        }()
        
        self.view.addSubview(scrollView)

        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(textView)
                        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: textView.frame.width, height: textView.frame.height))
        navBar.barTintColor = .white
        self.textView.addSubview(navBar)
        let button = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissDetailsVC))
        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = button
        navBar.setItems([navItem], animated: true)
    }
    
    @objc func dismissDetailsVC() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailsViewController: DetailsViewModelDelegate {
    
    func passRequestData(string: String) {
        self.readme = string
        DispatchQueue.main.async {
            self.textView.text = "\nFull name: \(self.fullName)" + "\n\n" + "URL: \(self.url)" + "\n\n" + "Stargazers: \(self.stargazers)" + "\n\n" + "Forks: \(self.forks)" + "\n\n" + "Watchers: \(self.watchers)" + "\n\n" + "Readme content: \(self.readme)"
        }
    }
}
