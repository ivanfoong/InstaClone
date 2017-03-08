//
//  FeedCell.swift
//  InstaClone
//
//  Created by Ivan Foong on 3/7/17.
//  Copyright © 2017 Ivan Foong. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        feedImageView.image = nil
        userIdLabel.text = nil
        timestampLabel.text = nil
    }
}
