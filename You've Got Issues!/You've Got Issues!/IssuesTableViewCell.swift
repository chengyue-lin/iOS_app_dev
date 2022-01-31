//
//  IssuesTableViewCell.swift
//  You've Got Issues!
//
//  Created by Ian on 2022/1/29.
//

import UIKit

class IssuesTableViewCell: UITableViewCell {

    @IBOutlet var closeTitle: UILabel!
    @IBOutlet var closeUserName: UILabel!
    @IBOutlet var closedImage: UIImageView!
    @IBOutlet var openTitle: UILabel!
    @IBOutlet var openUserName: UILabel!
    @IBOutlet var openImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
