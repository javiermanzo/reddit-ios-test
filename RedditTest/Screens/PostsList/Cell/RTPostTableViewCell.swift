//
//  RTPostTableViewCell.swift
//  RedditTest
//
//  Created by Javi on 11/03/2019.
//  Copyright © 2019 Javier Manzo. All rights reserved.
//

import UIKit

class RTPostTableViewCell: UITableViewCell {

    @IBOutlet weak var readView: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }
    
    func setUpView() {
        self.backgroundColor = UIColor.style(.one)
        let disclosureView = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        disclosureView.contentMode = .scaleAspectFit
        disclosureView.image = UIImage(named: "accesory_disclosure")
        self.accessoryView = disclosureView
        
        self.thumbImageView.roundCorners()
        
        self.readView.circleView()
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        
    }
}
