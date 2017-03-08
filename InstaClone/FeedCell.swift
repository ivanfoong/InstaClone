//
//  FeedCell.swift
//  InstaClone
//
//  Created by Ivan Foong on 3/7/17.
//  Copyright © 2017 Ivan Foong. All rights reserved.
//

import UIKit
import AlamofireImage

class FeedCell: UITableViewCell {
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var feedTitleLabel: UILabel!

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
        feedTitleLabel.text = nil
    }
}

extension FeedCell: CellDataSource {
    func configureCell(with data: BaseCellData) {
        if let cellData = data as? CellData {
            userIdLabel.text = cellData.userId
            feedTitleLabel.text = cellData.feedTitle
            if let imageUrl = cellData.feedImageUrl {
                feedImageView.af_setImage(withURL: imageUrl)
            }
        }
    }
    
    class CellData: BaseCellData {
        var feedImageUrl: URL?
        var userId: String?
        var feedTitle: String?
        
        init(feedImageUrl: URL?, userId: String?, feedTitle: String?) {
            self.feedImageUrl = feedImageUrl
            self.userId = userId
            self.feedTitle = feedTitle
            super.init()
        }
    }
}

