//
//  RTPostTableViewCell.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import UIKit

class RTPostTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }
    
    func setUpView() {
        self.backgroundColor = UIColor.style(.one)
    }
}
