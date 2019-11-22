//
//  SearchViewModel.swift
//  githubApi
//
//  Created by Vlad Țîrloiu on 19/11/2019.
//  Copyright © 2019 Vlad Țîrloiu. All rights reserved.
//

import UIKit

protocol SearchViewModelDelegate {
    func showGeneralError(message: String)
}

struct ResponseData: Codable {
    let items: [Items]
}

struct Items: Codable {
    let stargazers_count: Int?
}

class SearchViewModel {
    
    var delegate: SearchViewModelDelegate?
    
    func searchText(searchedText: String) {
        print(searchedText)
        
        guard let url = URL(string: "https://api.github.com/search/repositories?q=topic:\(searchedText)") else {return}
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
                    if searchedText.count == 0 {
                        self.delegate?.showGeneralError(message: "Textfield is empty")
                    } else {
                        print(responseData.items.first!)
                    }
                } catch {
                    print(error)
                }
            }
            
        }.resume()
    }
}
