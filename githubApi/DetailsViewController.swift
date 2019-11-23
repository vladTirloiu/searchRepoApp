//
//  DetailsViewController.swift
//  githubApi
//
//  Created by Vlad Țîrloiu on 22/11/2019.
//  Copyright © 2019 Vlad Țîrloiu. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = "hello world"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
