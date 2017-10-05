//
//  YTFirstStartPresenter.swift
//  pet1
//
//  Created by Yuriy T on 27.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import Foundation
import PromiseKit

class YTFirstStartPresenter: NSObject {
    weak var vc: YTFirstStartViewController?
    private let authService: YTAuthService
    var manager: YTRequestProtocol!
    
    init(withViewController vc:YTFirstStartViewController) {
        
        self.vc = vc
        authService = YTAuthService.shared
        manager = YTRequestManager.shared
//        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    func loginWithFB() -> Promise<YTUser> {
        let pendingOutside = Promise<YTUser>.pending()
        
        authService.getFBAccessToken().then { token -> Promise<YTUser> in
            let pending = Promise<YTUser>.pending()
            
            // make call api with fb token
            pending.fulfill(YTUser())
            
            return pending.promise
            }.then { user -> Void in
                // save user and etc
                debugPrint("save user")
                pendingOutside.fulfill(user)
                
//                return Promise { fulfill, reject in
//                    fulfill(user)
//                }
            }.catch { error in
                pendingOutside.reject(error)
                print(error.localizedDescription)
        }
        
        return pendingOutside.promise
    }
    
    func a() {
        manager
            .request(params: YTUserRequest.getMe, additionalParameters: nil, additionalHeader: nil)
            .then { json in
                debugPrint(json)
            }
            .catch { error in
                debugPrint(error.localizedDescription)
        }
    }
}
