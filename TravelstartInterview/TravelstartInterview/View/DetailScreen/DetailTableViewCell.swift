//
//  DeatilTableViewCell.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/5.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValue(title: String, info: String) {
        
        titleLabel.text = title
        
        infoLabel.text = info
    }

}
