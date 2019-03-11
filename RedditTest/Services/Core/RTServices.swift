//
//  RTServices.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import Foundation

enum RTService: String {
    case topPosts = "/top.json"
    
    func url() -> String {
        return "\(RTConstant.baseUrl)\(self.rawValue)"
    }
}
