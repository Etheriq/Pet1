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
        return Promise { fulfill, reject in
            fulfill(YTUser())
        }
    }

    func validateLogin() -> Bool {
        guard let login = vc.loginTextField.text, !login.isEmpty else { return false }
        guard let password = vc.passwordTextField.text, !password.isEmpty else { return false }
        
        return true
    }
    
//    func validate(with login: String, andWithPassword: String) -> Bool {
//        return true
//    }

    
//    func c() {
//        let loginPromise = makeLogin()
//        
//        when(fulfilled: loginPromise).then { user in
//        
//        }
    
//        when(fulfilled: loginPromise).then { user -> Void in
//            
//        }
//    }
    
}
