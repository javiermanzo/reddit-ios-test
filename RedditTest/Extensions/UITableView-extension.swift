//
//  UITableView-extension.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCellNib<T: UITableViewCell>(_: T.Type) {
        self.register(T.cellNib, forCellReuseIdentifier: T.reusableIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_: T.Type) -> T? {
        if let cell = self.dequeueReusableCell(withIdentifier: T.reusableIdentifier) as? T {
            return cell
        }
        return nil
    }
    
    func clearExtraSeparators() {
        self.tableFooterView = UIView()
    }
}
