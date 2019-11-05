//
//  JGProgressHUDWrapper.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/5.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import JonAlert

enum AlertType {
    
    case success(String)
    
    case failure(String)
}

class JonAlert {
    
    static func show(type: AlertType) {
        
        switch type {
            
        case .success(let message):
            
            showSuccess(message: message)
            
        case .failure(let message):
            
            showError(message: message)
        }
    }
        
    static func showSuccess(message: String = "success") {
        
        if !Thread.isMainThread {
            
            DispatchQueue.main.async {
                
                showSuccess(message: message)
            }
            
            return
        }
        
        JonAlert.showSuccess(message: message)
    }
    
    static func showError(message: String = "Failure") {
        
        if !Thread.isMainThread {
            
            DispatchQueue.main.async {
                
                showError(message: message)
            }
            
            return
        }
        
        JonAlert.showError(message: message)
    }
}
