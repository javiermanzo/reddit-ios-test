//
//  RTDetailsViewController.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import UIKit

class RTDetailsViewController: UIViewController {
    
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var postImageView: UIImageView!
    @IBOutlet private var emptyStateView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Post"
        
        self.setUpImageView()
    }
    
    func setUpImageView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        self.postImageView.isUserInteractionEnabled = true
        self.postImageView.addGestureRecognizer(tap)
    }
    
    func setUpValues(post: RTPost) {
        self.authorLabel.text = post.data.author
        self.titleLabel.text = post.data.title
        
        if  let preview = post.data.preview, !preview.images.isEmpty {
            let image = preview.images[0].source
            let imageUrl = image.url.replacingOccurrences(of: "amp;", with: "")
            self.postImageView.loadImage(withUrl: imageUrl, animated: true)
        }
        
        self.emptyStateView.isHidden = true
    }
    
    @objc private func imageTapped(gesture: UITapGestureRecognizer) {
        RTPermissions.getGalleryPermission { (granted) in
            if granted {
                self.postImageView.savePhotoInGallery()
            } else {
                RTPermissions.openAppSettings()
            }
        }
    }
}
