//
//  Kingfisher.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/4.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(_ urlString: String?, placeHolder: UIImage? = nil) {
        
        guard let urlString = urlString else { return }
        
        let url = URL(string: urlString)
        
        self.kf.setImage(with: url, placeholder: placeHolder)

    }
}
