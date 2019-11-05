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
    
    @IBOutlet weak var mainTouristViewTableView: UITableView! {
        
        didSet {
            
            mainTouristViewTableView.delegate = self.delegate
            mainTouristViewTableView.dataSource = self.delegate
            
        }
    }
    
    weak var delegate: MainTouristListViewDelegate? {
        
        didSet {
            
            guard let mainTouristViewTableView = mainTouristViewTableView else { return }
            
            mainTouristViewTableView.delegate = self.delegate
            mainTouristViewTableView.dataSource = self.delegate
        }
    }
    
}
