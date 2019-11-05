//
//  DetailViewController.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/5.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailTouristData: TouristListData?
    
    let tableTitleName: [String] = ["景點名稱", "景點位置", "交通路線", "景點介紹"]
    
    @IBOutlet weak var detailTableView: UITableView! {
        didSet {
            detailTableView.delegate = self
            detailTableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = detailTouristData?.title

    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableTitleName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let detailCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: DetailTableViewCell.self),
            for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
        
        guard let data = detailTouristData else { return UITableViewCell() }
        
        if indexPath.row == 0 {
            
            detailCell.setValue(title: tableTitleName[indexPath.row],
                                info: data.title)
            
        } else if indexPath.row == 1 {
            
            detailCell.setValue(
                title: tableTitleName[indexPath.row],
                info: data.address)
            
        } else if indexPath.row == 2 {
            
            detailCell.setValue(
                title: tableTitleName[indexPath.row],
                info: data.info ?? "")
            
        } else {
            
            detailCell.setValue(
                title: tableTitleName[indexPath.row],
                info: data.introduction)
        }

        return detailCell
    }
    
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
