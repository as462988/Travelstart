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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let imageData = detailTouristData?.photoURL else { return nil }
        
        return DetailPageHeaderView(
            numberOfImage: imageData.count,
            images: imageData)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableTitleName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let detailCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: DetailTableViewCell.self),
            for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
        
        guard let data = detailTouristData else { return UITableViewCell() }
        
        let title = tableTitleName[indexPath.row]
        
        switch indexPath.row {
        case 0:
            
            detailCell.setValue(
                title: title,
                info: data.title)
        case 1:
            
            detailCell.setValue(
                title: title,
                info: data.address)
            
        case 2:
            
            detailCell.setValue(
                title: title,
                info: data.info ?? "")
            
        default:
            detailCell.setValue(
                title: title,
                info: data.introduction)
        }
    
        return detailCell
    }
    
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.height / 3
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
}
