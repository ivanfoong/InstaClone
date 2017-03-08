//
//  CommentCell.swift
//  InstaClone
//
//  Created by Ivan Foong on 3/7/17.
//  Copyright © 2017 Ivan Foong. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

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
        userIdLabel.text = nil
        commentLabel.text = nil
    }
}

extension CommentCell: CellDataSource {
    func configureCell(with data: BaseCellData) {
        if let cellData = data as? CellData {
            userIdLabel.text = cellData.userId
            commentLabel.text = cellData.comment
        }
    }
    
    class CellData: BaseCellData {
        var userId: String?
        var comment: String?
        
        init(userId: String?, comment: String?) {
            self.userId = userId
            self.comment = comment
            super.init()
        }
    }
}
