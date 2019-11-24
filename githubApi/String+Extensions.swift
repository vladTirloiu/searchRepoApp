//
//  String+Extensions.swift
//  githubApi
//
//  Created by Vlad Țîrloiu on 24/11/2019.
//  Copyright © 2019 Vlad Țîrloiu. All rights reserved.
//

import UIKit

extension String {
    //: ### Base64 encoding a string
        func base64Encoded() -> String? {
            if let data = self.data(using: .utf8) {
                return data.base64EncodedString()
            }
            return nil
        }

    //: ### Base64 decoding a string
        func base64Decoded() -> String? {
            if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
                return String(data: data, encoding: .utf8)
            }
            return nil
        }
}
