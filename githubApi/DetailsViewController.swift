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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(modalScan))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func modalScan() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
