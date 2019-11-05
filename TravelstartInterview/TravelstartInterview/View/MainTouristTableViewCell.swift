//
//  MainTouristTableViewCell.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/4.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import UIKit

protocol MainTouristTableViewCellDelegate: UICollectionViewDelegate, UICollectionViewDataSource, AnyObject {
    
}

class MainTouristTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView! {
        
        didSet {
            
            imageCollectionView.delegate = self.delegate
            imageCollectionView.dataSource = self.delegate
            
        }
    }
    
    weak var delegate: MainTouristTableViewCellDelegate? {
        
        didSet {
            
            imageCollectionView.delegate = self.delegate
            imageCollectionView.dataSource = self.delegate
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView(collectionView: self.imageCollectionView)
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setValue(title: String, info: String) {
      
        titleLabel.text = title
        
        infoLabel.text = info
    }
    
    func setupCollectionView(collectionView: UICollectionView) {

        collectionView.contentInset.right = 12
        
        collectionView.reloadData()
        
    }

}
