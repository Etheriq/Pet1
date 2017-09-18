//
//  YTAuthService.swift
//  pet1
//
//  Created by Yuriy T on 18.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import Foundation

protocol AuthServiceProtocol {
    func isAuthorized() -> Bool
}

class YTAuthService: NSObject, AuthServiceProtocol {
    
    override init() {
         super.init()
    }
    
    // Mark: - AuthServiceProtocol
    func isAuthorized() -> Bool {
        return false
    }
    
}
