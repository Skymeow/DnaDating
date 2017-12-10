//
//  MatchedCell.swift
//  Dndating
//
//  Created by Sky Xu on 12/10/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class MatchedCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var profileImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
