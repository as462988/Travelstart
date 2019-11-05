//
//  Bundle+Extension.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/6.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import Foundation

extension Bundle {
    // swiftlint:disable force_cast
    static func ValueForString(key: String) -> String {
        
        return Bundle.main.infoDictionary![key] as! String
    }
    // swiftlint:enable force_cast
}
