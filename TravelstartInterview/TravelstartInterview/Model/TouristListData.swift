//
//  TouristCellViewModel.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/4.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import Foundation

struct TouristDataResults: Codable {
    
    let results: [TouristListData]
}

struct TouristResult: Codable {
    
    let result: TouristDataResults
}

struct TouristListData: Codable {
    
    let title: String
    
    let introduction: String
    
    let address: String
    
    let info: String?
    
    let photoFile: String
    
    var photoURL: [String] {
        
        return PhotoURL.separate(fileName: photoFile)
    }
    
    enum CodingKeys: String, CodingKey {
        
        case title = "stitle"
        
        case introduction = "xbody"
        
        case address, info
        
        case photoFile = "file"
    }
    
}

struct PhotoURL {
    
    static func separate(fileName: String) -> [String] {

        let photoArray = fileName.components(separatedBy: "http:")
        
        var newPhotoArray = [String]()

        for number in 1..<photoArray.count {
            
            if photoArray[number].contains(".jpg") || photoArray[number].contains(".JPG") {

                newPhotoArray.append("http:" + photoArray[number])
            }
        }

        return newPhotoArray
    }
}
