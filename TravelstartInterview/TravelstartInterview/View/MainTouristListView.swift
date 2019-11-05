//
//  MainTouristListView.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/5.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import UIKit

protocol MainTouristListViewDelegate: UITableViewDelegate, UITableViewDataSource, AnyObject {
    
}

class MainTouristListView: UIView {
    
    @IBOutlet weak var mainTouristViewTabelView: UITableView! {
        
        didSet {
            
            mainTouristViewTabelView.delegate = self.delegate
            mainTouristViewTabelView.dataSource = self.delegate
            
        }
    }
    
    weak var delegate: MainTouristListViewDelegate? {
        
        didSet {
            
            guard let mainTouristViewTabelView = mainTouristViewTabelView else { return }
            
            mainTouristViewTabelView.delegate = self.delegate
            mainTouristViewTabelView.dataSource = self.delegate
        }
    }
    
}
