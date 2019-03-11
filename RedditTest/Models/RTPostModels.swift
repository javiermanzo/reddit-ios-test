//
//  RTPostModels.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import Foundation

struct RTSource: Codable {
    let url: String
    let width: Int
    let height: Int
}

struct RTImage: Codable {
    let source: RTSource
    let resolutions: [RTSource]?
}

struct RTPreview: Codable {
    let images: [RTImage]
    let enabled: Bool
}

class RTPostData: Codable {
    let id: String
    let title: String
    let authorFullname: String
    let numberOfComments: Int
    let creationDateTimestamp: Double
    let thumbImageUrl: String?
    let preview: RTPreview?
    var readed = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case authorFullname = "author_fullname"
        case numberOfComments = "num_comments"
        case creationDateTimestamp = "created_utc"
        case thumbImageUrl = "thumbnail"
        case preview
    }
}

class RTPost: Codable, Equatable {
    var data: RTPostData
    
    static func == (lhs: RTPost, rhs: RTPost) -> Bool {
        return lhs.data.id == rhs.data.id
    }
}

class RTResponseData: Codable {
    let children: [RTPost]
}

class RTResponse: Codable {
    let data: RTResponseData
}
