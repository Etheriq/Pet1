//
//  YTAuthService.swift
//  pet1
//
//  Created by Yuriy T on 18.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import Foundation
import PromiseKit
import FacebookLogin
import FBSDKCoreKit

protocol AuthServiceProtocol {
    func isAuthorized() -> Bool
    func getFBAccessToken() -> Promise<String>
    func fbLogout()
}

enum AuthErrors: Error {
    case signInFBCanceled
    case signInFBError(error: Error)
}

class YTAuthService: AuthServiceProtocol {
    
    static let shared = YTAuthService()
    private init() {}
    
    // Mark: - AuthServiceProtocol
    func isAuthorized() -> Bool {
        return false
    }
    
    func getFBAccessToken() -> Promise<String> {
        let pending = Promise<String>.pending()
        
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn([.publicProfile, .email, .userFriends], viewController: nil) { result in
            switch result {
            case .cancelled:
                debugPrint("canceled")
                pending.reject(AuthErrors.signInFBCanceled)
            case .failed(let error):
                print(error.localizedDescription)
                
                pending.reject(AuthErrors.signInFBError(error: error))
            case .success(let grantedPermissions, let declinedPermissions, let userInfo):
                debugPrint("Token: \(userInfo.authenticationToken)")
                debugPrint("Token2: \(FBSDKAccessToken.current().tokenString)")
                debugPrint("Granted: \(grantedPermissions.map { "\($0)" }.joined(separator: " "))")
                debugPrint("Declined: \(declinedPermissions.map { "\($0)" }.joined(separator: " "))")
                
                pending.fulfill(userInfo.authenticationToken)
            }
        }
        
        return pending.promise
    }
    
    func fbLogout() {
        let loginManager = LoginManager()
        loginManager.logOut()
    }
}
