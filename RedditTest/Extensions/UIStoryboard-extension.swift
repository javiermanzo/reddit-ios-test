//
//  UIStoryboard-extension.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    enum RTStoryboard: String {
        case main = "Main"
    }
    
    convenience init(storyboard: RTStoryboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>(_: T.Type) -> T? {
        guard let viewController = self.instantiateViewController(withIdentifier: T.reusableIdentifier) as? T else {
            return nil
        }
        return viewController
    }
}
