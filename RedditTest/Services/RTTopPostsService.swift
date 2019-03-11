//
//  RTTopPostsService.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import Foundation

class RTTopPostsService {
    func get(success: @escaping (_ posts: [RTPost])->(), failure: @escaping (_ error: Error?)->()) {
        RTBaseService.request(model: RTResponse.self, method: .get, service: .topPosts) { (result) in
            switch result {
            case .error(let e):
                failure(e)
            case .success(let response):
                success(response.data.children)
            }
        }
    }
}
