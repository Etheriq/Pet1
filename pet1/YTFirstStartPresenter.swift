//
//  YTFirstStartPresenter.swift
//  pet1
//
//  Created by Yuriy T on 27.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import Foundation
import PromiseKit

enum LoginError: Error {
    case fbLoginError
}

class YTFirstStartPresenter {
    fileprivate let vc: YTFirstStartViewController
    
    private var fbAccessToken: String?
    private let authService: YTAuthService
    
    init(withViewController vc:YTFirstStartViewController) {
        self.vc = vc
        authService = YTAuthService.shared
    }
    
    func loginWithFB() -> Promise<YTUser> {
        let pending = Promise<YTUser>.pending()
        
        authService.getFBAccessToken().then { token -> Promise<YTUser> in
            self.fbAccessToken = token
            
            let pending = Promise<YTUser>.pending()
            // make call api with fb token
            pending.fulfill(YTUser())
            
            return pending.promise
            }.then { user -> Promise<YTUser> in
                // save user and etc
                
                return Promise { fulfill, reject in
                    fulfill(user)
                }
            }.catch { error in
                print(error.localizedDescription)
        }
        
        return pending.promise
    }
    
    func getFBAccessToken() -> String? {
        return fbAccessToken
    }
    
}
