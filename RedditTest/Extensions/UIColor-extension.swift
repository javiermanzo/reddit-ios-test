//
//  UIColor-extension.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import UIKit

extension UIColor {
    enum RTColor: String {
        case one
        case two
        case three
        case four
        case five
    }
    
    convenience private init?(style: RTColor) {
        self.init(named: style.rawValue)
    }
    
    static func style(_ style: RTColor) -> UIColor {
        return UIColor(named: style.rawValue) ?? UIColor.white
    }
}
