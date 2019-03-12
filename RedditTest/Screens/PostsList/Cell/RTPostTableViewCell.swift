//
//  RTPostTableViewCell.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import UIKit

protocol RTPostCellDelegate {
    func dismissPost(post: RTPost)
}

class RTPostTableViewCell: UITableViewCell {
    
    @IBOutlet private var readView: UIView!
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var thumbImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var commentsLabel: UILabel!
    @IBOutlet private var dismissButton: UIButton!
    
    var post: RTPost?
    
    var delegate: RTPostCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }
    
    private func setUpView() {
        self.backgroundColor = UIColor.style(.one)
        let disclosureView = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        disclosureView.contentMode = .scaleAspectFit
        disclosureView.image = UIImage(named: "accesory_disclosure")
        self.accessoryView = disclosureView
        
        self.thumbImageView.roundCorners()
        
        self.readView.circleView()
    }
    
    func setUpValues(post: RTPost, delegate: RTPostCellDelegate) {
        self.post = post
        self.delegate = delegate
        self.authorLabel.text = post.data.author
        self.timeLabel.text = Date(timeIntervalSince1970: post.data.creationDateTimestamp).timeAgoSinceDate(numericDates: true)
        self.titleLabel.text = post.data.title
        self.commentsLabel.text = "\(post.data.numberOfComments) comments"
        self.readView.isHidden = post.data.readed
        
        if let urlString = post.data.thumbImageUrl {
            self.thumbImageView.loadImage(withUrl: urlString)
        }
    }
    
    @IBAction private func dismissAction(_ sender: Any) {
        if let post = self.post {
            self.delegate?.dismissPost(post: post)
        }
    }
}
