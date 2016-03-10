//
//  ShotCell.swift
//  ShotsTest
//
//  Created by Sergei Makarov on 10.03.16.
//  Copyright © 2016 Sergei Makarov. All rights reserved.
//

import UIKit

class ShotCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}