//
//  ViewController.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/10/31.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import UIKit
import Network

class MainListViewController: UIViewController {
    
    var errorMessage: String = "目前讀取不到資料，請稍後再試"
    
    @IBOutlet weak var mainListView: MainTouristListView! {
        
        didSet {
            mainListView.delegate = self
        }
    }
    
    var touristListData: [TouristListData] = [] {
        
        didSet {
            mainListView.mainTouristViewTabelView.reloadData()
        }
    }
    
    let monitor = NWPathMonitor()
    
    let touristProvider = TouristProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        checkNetwork()
    }
    
    func fetchData() {
        
        let request = TouristRequest()
        
        touristProvider.fetchData(request: request) {[weak self] (result) in
            
            switch result {
                
            case.success(let data):
                
                self?.touristListData += data.result.results
                
            case .failure(let error):
                
                //                ProgressHUD.showFailure(text: self?.errorMessage ?? "error")
                
                print("Error:\(error)")
                
            }
        }
    }
    
    func checkNetwork() {
        
        monitor.pathUpdateHandler = { [weak self] path in
            
            if path.status == .satisfied {
                
                ProgressHUD.showSuccess()
                print("connected")
                
            } else {
                
                ProgressHUD.showFailure(text: self?.errorMessage ?? "error")
                
                print("no connection")
                
            }
        }
        monitor.start(queue: DispatchQueue.global())
    }
    
}

extension MainListViewController: MainTouristListViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return touristListData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let mainCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: MainTouristTableViewCell.self),
            for: indexPath) as? MainTouristTableViewCell else {
                
                return UITableViewCell()
                
        }
        
        mainCell.setValue(title: touristListData[indexPath.section].title,
                          info: touristListData[indexPath.section].introduction)
        
        mainCell.delegate = self
        mainCell.imageCollectionView.tag = indexPath.section
        mainCell.imageCollectionView.reloadData()
        
        return mainCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        
        headerView.backgroundColor = .lightGray
        headerView.alpha = 0.5
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
}

extension MainListViewController: MainTouristTableViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return touristListData[collectionView.tag].photoURL.count

    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let mainImageCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(
                describing: MainTouristImageCollectionViewCell.self),
            for: indexPath) as? MainTouristImageCollectionViewCell else {
                
                return UICollectionViewCell()
        }
        mainImageCell.imageView.loadImage(touristListData[collectionView.tag].photoURL[indexPath.row])
        
        return mainImageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8
    }
    
}
