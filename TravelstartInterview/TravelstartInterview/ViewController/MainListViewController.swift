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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
//
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension MainListViewController: MainTouristTableViewCellDelegate {
    
    // MARK: UICollectionViewDataSource
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
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let detailVC = storyboard.instantiateViewController(
            identifier:String(describing: DetailViewController.self)) as? DetailViewController else { return }
        
        show(detailVC, sender: nil)
        print("tapImage")
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8
    }
    
}
