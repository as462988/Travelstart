//
//   TouristRequest.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/4.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import Foundation

class TouristRequest: Request {

    var headers: [ String: String]? {
        
        return nil
    }
    
    var body: Data? {
        
        return nil
        
    }
    
    var method: String = HTTPMethod.GET.rawValue
    
    var offset = 0
    
    var endPoint: URL {
        
        var urlComponent = URLComponents()
        
        urlComponent.scheme = "https"
        
        urlComponent.host = "data.taipei"
        
        urlComponent.path = "/opendata/datalist/apiAccess"
        
        urlComponent.queryItems = [
        
            URLQueryItem(name: "scope", value: "resourceAquire"),
            
            URLQueryItem(name: "rid", value: "36847f3f-deff-4183-a5bb-800737591de5"),
            
            URLQueryItem(name: "limit", value: "10"),
            
            URLQueryItem(name: "offset", value: String(offset))
        
        ]
        
        offset += 10
                      
        return urlComponent.url!
    }

}
