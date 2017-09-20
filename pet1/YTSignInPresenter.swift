//
//  YTSignInPresenter.swift
//  pet1
//
//  Created by Yuriy T on 19.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit
import PromiseKit

protocol YTSignInPresenterProtocol {
    func validateLogin() -> Bool
    func makeLogin() -> Promise<YTUser>
}

class YTSignInPresenter: YTSignInPresenterProtocol {

    fileprivate let vc: YTSignInViewController
    
    init(withViewController vc: YTSignInViewController) {
        self.vc = vc
    }
    
    // MARK: - YTSignInPresenterProtocol
    
    func makeLogin() -> Promise<YTUser> {
        let pending = Promise<YTUser>.pending()
        pending.fulfill(YTUser())
        
        return pending.promise
        
//        return Promise { fulfill, reject in
//            fulfill(YTUser())
//        }
    }

    func validateLogin() -> Bool {
        guard let login = vc.loginTextField.text, !login.isEmpty else { return false }
        guard let password = vc.passwordTextField.text, !password.isEmpty else { return false }
        
        return true
    }
    
    func c() {
        let loginPromise = makeLogin()
        let ee = makeLogin()
        
        loginPromise.then { user in
            debugPrint(user.dob)
        }
        
        when(fulfilled: loginPromise, ee)
            .then { u1, u2 -> Void in
                
            }
            .catch { error in
                // handle error
            }

    }
    
}
