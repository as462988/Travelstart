//
//   TouristRequest.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/4.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import Foundation

enum QueryName: String {
    
    case scope
    
    case rid
    
    case limit
    
    case offset
}

class TouristRequest: Request {
    
    var offset: Int
    
    var limit: Int
    
    init(offset: Int, limit: Int ) {
        self.offset = offset
        self.limit = limit
    }

    var headers: [ String: String]? {
        
        return nil
    }
    
    var body: Data? {
        
        return nil
        
    }
    
    var method: String {
        
        return HTTPMethod.GET.rawValue
        
    }
    
    var endPoint: URL {
        
        var urlComponent = URLComponents()
        
        urlComponent.scheme = "https"
        
        urlComponent.host = "data.taipei"
        
        urlComponent.path = "/opendata/datalist/apiAccess"
        
        urlComponent.queryItems = [
        
            URLQueryItem(name: QueryName.scope.rawValue, value: "resourceAquire"),
            
            URLQueryItem(name: QueryName.rid.rawValue, value: Bundle.ValueForString(key: Constant.touristRidValue)),
            
            URLQueryItem(name: QueryName.limit.rawValue, value: String(limit)),
            
            URLQueryItem(name: QueryName.offset.rawValue, value: String(offset))
        
        ]
        
        offset += limit
                      
        return urlComponent.url!
    }

}
