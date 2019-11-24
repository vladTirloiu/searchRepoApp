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
    func passRequestData(fullNamesArray: [String], urlsArray: [String], forksArray: [Int], stargazersArray: [Int], watchersArray: [Int])
    func showDetailsVC()
}

struct ResponseData: Codable {
    let items: [Items]
}

struct Items: Codable {
    let full_name: String?
    let url: String?
    let forks: Int?
    let stargazers_count: Int?
    let watchers_count: Int?
}

class SearchViewModel {
    
    var fullNamesArray = Array<String>()
    var urlsArray = Array<String>()
    var forksArray = Array<Int>()
    var stargazersArray = Array<Int>()
    var watchersArray = Array<Int>()
    
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
                        for (index, _) in responseData.items.enumerated() {
                            if let fullName = responseData.items[index].full_name {
                                self.fullNamesArray.append(fullName)
                            }
                            if let repoURL = responseData.items[index].url {
                                self.urlsArray.append(repoURL)
                            }
                            if let forks = responseData.items[index].forks {
                                self.forksArray.append(forks)
                            }
                            if let stargazers = responseData.items[index].stargazers_count{
                            self.stargazersArray.append(stargazers)
                            }
                            if let watchers = responseData.items[index].watchers_count{
                            self.watchersArray.append(watchers)
                            }
                        }
                        self.delegate?.passRequestData(fullNamesArray: self.fullNamesArray, urlsArray: self.urlsArray, forksArray: self.forksArray, stargazersArray: self.stargazersArray, watchersArray: self.watchersArray)
                        self.fullNamesArray.removeAll()
                        self.urlsArray.removeAll()
                        self.forksArray.removeAll()
                        self.stargazersArray.removeAll()
                        self.watchersArray.removeAll()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func cellTapped() {
        delegate?.showDetailsVC()
    }
}
