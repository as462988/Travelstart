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
    
    var touristListData: [TouristListData] = []
    
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
                
            case .failure(let error):
                
                print("Error:\(error)")
                
            }
        }
    }
}

extension MainListViewController: MainTouristListViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return touristListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let mainCell = mainListView.mainTouristViewTabelView.dequeueReusableCell(
            withIdentifier: String(describing: MainTouristTableViewCell.self),
            for: indexPath) as? MainTouristTableViewCell else {
                
            return UITableViewCell()
                
        }
        
        mainCell.setValue(title: touristListData[indexPath.row].title,
                          info: touristListData[indexPath.row].introduction)
        
        return mainCell
    }
}
