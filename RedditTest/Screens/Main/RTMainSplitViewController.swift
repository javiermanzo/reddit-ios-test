//
//  RTMainSplitViewController.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import UIKit

class RTMainSplitViewController: UISplitViewController {
    
    var postsListController: RTPostsListViewController?
    var detailsController: RTDetailsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        if UIApplication.shared.statusBarOrientation.isLandscape {
            preferredDisplayMode = .allVisible
        } else {
            preferredDisplayMode = .primaryHidden
        }
        
        let storyboard = UIStoryboard(storyboard: .main)
        self.detailsController = storyboard.instantiateViewController(RTDetailsViewController.self)
        
        if let leftNavController = self.viewControllers.first as? UINavigationController,
            let masterViewController = leftNavController.topViewController as? RTPostsListViewController {
            self.postsListController = masterViewController
            self.postsListController?.delegate = self
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            preferredDisplayMode = .allVisible
        } else {
            preferredDisplayMode = .primaryHidden
        }
    }
}

extension RTMainSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

extension RTMainSplitViewController: RTPostsListDelegate {
    func postselected(post: RTPost) {
        guard let vc = self.detailsController else { return }
        let _ = vc.view
        vc.setUpValues(post: post)
        
        self.showDetailViewController(vc, sender: self)
    }
}
