//
//  RTReusableIdentifier.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import Foundation

public protocol RTReusableIdentifier {
    static var reusableIdentifier: String { get }
}

public extension RTReusableIdentifier {
    static var reusableIdentifier: String {
        return "\(self)"
    }
}
