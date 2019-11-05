//
//  MainTouristTableViewCell.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/4.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import UIKit

class MainTouristTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setValue(title: String, info: String) {
      
        titleLabel.text = title
        
        infoLabel.text = info
    }

}
