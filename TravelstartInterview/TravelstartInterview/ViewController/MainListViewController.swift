//
//  ViewController.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/10/31.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import UIKit

class MainListViewController: UIViewController {
    
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
    
    var touristListImageData: [[String]] = []
    
    let touristProvider = TouristProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
    }
    
    func fetchData() {
        
        let request = TouristRequest()
        
        touristProvider.fetchData(request: request) {[weak self] (result) in
            
            switch result {
                
            case.success(let data):
                
                self?.touristListData += data.result.results
                
                print(self?.touristListData.count)
                print(data.result.results.count)
                print(data.result.results[1].photoURL)
                
            case .failure(let error):
                
                print("Error:\(error)")
                
            }
        }
    }
}

extension MainListViewController: MainTouristListViewDelegate, MainTouristTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return touristListData.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let mainCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: MainTouristTableViewCell.self),
            for: indexPath) as? MainTouristTableViewCell else {
                
            return UITableViewCell()
                
        }
        
        mainCell.setValue(title: touristListData[indexPath.row].title,
                          info: touristListData[indexPath.row].introduction)
        
//        mainCell.setValue(title: "aaaa", info: "aaassdeeee")
        
        mainCell.delegate = self
        return mainCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return touristListImageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let mainImageCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(
                describing: MainTouristImageCollectionViewCell.self),
            for: indexPath) as? MainTouristImageCollectionViewCell else {
                
            return UICollectionViewCell()
        }
        
        mainImageCell.imageView.loadImage(touristListImageData[indexPath.section][indexPath.row])
        
        return mainImageCell
    }
    
}
