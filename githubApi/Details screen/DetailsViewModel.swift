//
//  DetailsViewModel.swift
//  githubApi
//
//  Created by Vlad Țîrloiu on 23/11/2019.
//  Copyright © 2019 Vlad Țîrloiu. All rights reserved.
//

import UIKit

protocol DetailsViewModelDelegate {
//    func readmeRequest(repoName: String, ownerName: String)
}

class DetailsViewModel  {

    var delegate: DetailsViewModelDelegate?
    
//    func readmeRequest(repoName: String, ownerName: String) {
//                guard let url = URL(string: "https://api.github.com/repos/\(ownerName)/\(repoName)/readme") else {return}
//
//                let session = URLSession.shared
//                session.dataTask(with: url) { (data, response, error) in
//                    if let response = response {
//                        print(response)
//                    }
//                    if let data = data {
//                        do {
//                            let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
//
//                        } catch {
//                            print(error)
//                        }
//                    }
//                }.resume()
//    }
}


