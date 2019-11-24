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
    
    var fullName = ""
    
    @IBOutlet weak var referanceView: UIView!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = fullName + "sssadasmdioasiodmaiosdioasmdoiasdioasidmoiasmdoiasiodmioasdoiasmdio"
        
        self.detailsViewModel.delegate = self
                        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: referanceView.frame.width, height: referanceView.frame.height))
        navBar.barTintColor = .white
        self.referanceView.addSubview(navBar)
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

}
