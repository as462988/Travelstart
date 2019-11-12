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
    
    var errorMessage: String = "目前網路異常，請確認網路後再使用"
    
    @IBOutlet weak var mainListView: MainTouristListView! {
        
        didSet {
            mainListView.delegate = self
        }
    }
    
    var touristListData: [TouristListData] = [] {
        
        didSet {
            mainListView.mainTouristViewTableView.reloadData()
        }
    }
    
    let monitor = NWPathMonitor()
    
    var networkIsSuccess: Bool = false
    
    let touristProvider = TouristProvider()
    
    var request = TouristRequest(offset: 0, limit: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNetwork()
        setupNavigationBar()
        setupRefresher()
    }
    
    func setupRefresher() {
        //宣告加入header loading refresh, 並且宣告他的方法
        mainListView.mainTouristViewTableView.addHeadRefresh {
            self.touristListData = []
            self.request = TouristRequest(offset: 0, limit: 10)
            self.mainListView.mainTouristViewTableView.resetNoMore()
            self.fetchData()
        }
        //宣告加入footer loading refresh, 並且宣告他的方法
        mainListView.mainTouristViewTableView.addFootRefresh {
            self.fetchData()
        }
    }
    
    func fetchData() {
        
        if networkIsSuccess {
            
            touristProvider.fetchData(request: request) {[weak self] (result) in
                guard let mainTableView = self?.mainListView.mainTouristViewTableView else { return }
                
                DispatchQueue.main.async {
                    
                    mainTableView.endLoadingMore()
//                    mainTableView.cr.endHeaderRefresh()
//                    mainTableView.cr.endLoadingMore()
                }
                
                switch result {
                    
                case.success(let data):
                    
                    if data.result.results.count == 0 {
                        self?.mainListView.mainTouristViewTableView.noticeNoMoreData()
                        return
                    }
                    
                    if data.result.results.count >= 0 {
                        
                        self?.touristListData += data.result.results
                        
                        DispatchQueue.main.async {
                            self?.mainListView.mainTouristViewTableView.reloadData()
                        }
                        
                    }
                    
                case .failure:
                    
                    JonAlert.showError(message: self?.errorMessage ?? "")
                }
                
            }
        }
    }
    
    func checkNetwork() {
        
        monitor.pathUpdateHandler = { [weak self] path in
            
            if path.status == .satisfied {
                
                self?.networkIsSuccess = true
                self?.fetchData()
                print("connected")
                
            } else {
                
                JonAlert.showError(message: self?.errorMessage ?? "")
                self?.networkIsSuccess = false
                print("no connection")
                
            }
        }
        monitor.start(queue: DispatchQueue.global())
    }
    
    private func setupNavigationBar() {
        
        navigationItem.title = "台北市熱門景點"
        
        navigationController?.navigationBar.tintColor = .white
        
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
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
        
        return 8
    }
    
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
            identifier: String(describing: DetailViewController.self)) as? DetailViewController else { return }
        
        detailVC.detailTouristData = self.touristListData[collectionView.tag]
        
        show(detailVC, sender: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8
    }
    
}
