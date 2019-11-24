//
//  DetailsViewModel.swift
//  githubApi
//
//  Created by Vlad Țîrloiu on 23/11/2019.
//  Copyright © 2019 Vlad Țîrloiu. All rights reserved.
//

import UIKit

protocol DetailsViewModelDelegate {
    func passRequestData(string: String)
}

struct DVMResponseData: Codable {
    let content: String?
}

class DetailsViewModel  {

    var delegate: DetailsViewModelDelegate?
    
    func readmeRequest(ownerName: String, repoName: String) {
        guard let url = URL(string: "https://api.github.com/repos/\(ownerName)/\(repoName)/readme") else {return}
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let responseData = try JSONDecoder().decode(DVMResponseData.self, from: data)
                    
                    let tempString = responseData.content
                    if let decodedString = tempString?.base64Decoded() {
                        print(decodedString)
                        self.delegate?.passRequestData(string: decodedString)
                    }
                    
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}


