//
//  TouristCellViewModel.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/4.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import Foundation

struct TouristCellViewModel: Codable {
    
    let title: String
    
    let introduction: String
    
    let address: String
    
    let memoTime: String?
    
    let info: String?
    
    let photoFile: String
    
    var photoURL: [String] {
        
        return PhotoURL.separate(fileName: photoFile)
    }
    
    enum CodingKeys: String, CodingKey {
        
        case title = "stitle"
        
        case introduction = "xbody"
        
        case address, info
        
        case memoTime = "MEMO_TIME"
        
        case photoFile = "file"
    }
    
}

struct TouristResults: Codable {
    
    let results: [TouristCellViewModel]
}

struct TouristResult: Codable {
    
    let result: TouristResults
}
