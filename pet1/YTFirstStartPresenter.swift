//
//  YTFirstStartPresenter.swift
//  pet1
//
//  Created by Yuriy T on 27.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import Foundation
import PromiseKit
import FacebookLogin
import FacebookCore
import FBSDKCoreKit

enum LoginError: Error {
    case fbLoginError
}

class YTFirstStartPresenter {
    fileprivate let vc: YTFirstStartViewController
    
    private var fbAccessToken: String?
    
    init(withViewController vc:YTFirstStartViewController) {
        self.vc = vc
    }
    
    func loginWithFB() -> Promise<Void> {
        let pending = Promise<Void>.pending()
        
        let loginManager = LoginManager()
        
        loginManager.
        
//        loginManager.logIn([.publicProfile, .userFriends, .email], viewController: vc) { [weak self] (result, error) in
//            guard let _ = error else { return pending.reject(LoginError.fbLoginError) }
//
//            guard let result = result else { return pending.reject(LoginError.fbLoginError) }
//            self?.fbAccessToken = result.token.tokenString
//
//            pending.fulfill()
//        }
        
        return pending.promise
    }
    
    func getFBAccessToken() -> String? {
        return fbAccessToken
    }
    
}

//import Foundation
//import FacebookLogin
//import FacebookCore
//import FBSDKCoreKit
//
//class WelcomePresenterImplementation: WelcomePresenter {
//    
//    weak var outputDelegate: WelcomeModuleOutputDelegate?
//    var authService: AuthorizationService?
//    
//    convenience init(authService: AuthorizationService) {
//        self.init()
//        self.authService = authService
//    }
//    
//    func handleFacebookLogin() {
//        let loginManager = LoginManager()
//        loginManager.logOut()
//        
//        loginManager.logIn([.publicProfile, .userFriends, .email], viewController: nil) { (result) in
//            switch(result) {
//            case .success(grantedPermissions: _, declinedPermissions: _, token: _):
//                if let token = FBSDKAccessToken.current().tokenString {
//                    self.authService?.fbLogin(token: token).then { _ in
//                        self.outputDelegate?.loginedWithFacebook()
//                        }.catch(execute: { error in
//                            debugPrint(error)
//                        })
//                }
//            default: break
//            }
//        }
//}

