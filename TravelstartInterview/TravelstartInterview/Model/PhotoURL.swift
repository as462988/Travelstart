//
//  PhotoURL.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/4.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import Foundation

struct PhotoURL {
    
    static func separate(fileName: String) -> [String] {

        let photoArray = fileName.components(separatedBy: "http:")
        
        var newPhotoArray = [String]()

        for number in 1..<photoArray.count {
            
            if photoArray[number].contains(".mp3") || photoArray[number].contains(".flv") {

                continue
            }
                
            newPhotoArray.append("http:" + photoArray[number])
        }

        return newPhotoArray
    }
}
