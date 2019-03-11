//
//  UITableViewCell-extension.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import UIKit

extension UITableViewCell: RTReusableIdentifier {
    static internal var cellNib: UINib {
        return UINib(nibName: self.reusableIdentifier, bundle: Bundle.main)
    }
}
