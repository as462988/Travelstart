//
//  File.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/5.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import Foundation

class TouristProvider {
    
    let decoder = JSONDecoder()
    
    typealias InfoHandler = (Result<TouristResult>) -> Void
    
    func fetchData(request: TouristRequest, completion: @escaping InfoHandler ) {
       
        HTTPClient.shared.request(request) { [weak self] result in
            
            guard let strongSelf = self else { return }
            
            switch result {
                
            case .success(let data):
                
                do {
                    let products = try strongSelf.decoder.decode(TouristResult.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        completion(Result.success(products))
                    }
                    
                } catch {
                    
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
    }
    
}
