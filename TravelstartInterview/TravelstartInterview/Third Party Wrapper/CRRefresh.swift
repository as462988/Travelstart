//
//  CRRefresh.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/6.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import UIKit
import CRRefresh

extension UITableView {
    
    func addHeadRefresh(completion: @escaping () -> Void) {
        
        self.cr.addHeadRefresh(animator: NormalHeaderAnimator()) {
            completion()
        }
    }
    
    func addFootRefresh(completion: @escaping () -> Void) {
        
        self.cr.addFootRefresh(animator: NormalHeaderAnimator()) {
            
            completion()
        }
    }
    
    func resetNoMore(){
        self.cr.resetNoMore()
    }
    
    func stopLoadingMore() {
        
        self.cr.endLoadingMore()
        self.reloadData()
    }
    
    func noticeNoMoreData() {
        
        self.cr.noticeNoMoreData()
        self.cr.footer?.alpha = 1.0
    }
}
