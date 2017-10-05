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
import Google
import GoogleSignIn

protocol AuthServiceProtocol {
    func isAuthorized() -> Bool
    func getFBAccessToken() -> Promise<String>
    func getGoogleAccessToken() -> Promise<String>
    func fbLogout()
}

enum AuthErrors: Error {
    case signInFBCanceled
    case signInFBError(error: Error)
    case signInGoogleFailed
}

class YTAuthService: NSObject, AuthServiceProtocol {
    
    static let shared = YTAuthService()
    private override init() {
        super.init()
        
        var googleError: NSError?
        GGLContext.sharedInstance().configureWithError(&googleError)
        if googleError != nil {
            return
        }
        
        GIDSignIn.sharedInstance().delegate = self
        
//        GIDSignIn.sharedInstance().signIn()
    }
    
    // Mark: - AuthServiceProtocol
    func isAuthorized() -> Bool {
        return false
    }
    
    func getGoogleAccessToken() -> Promise<String> {
        let pending = Promise<String>.pending()
        
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
        if let googleUser = GIDSignIn.sharedInstance().currentUser {
            pending.fulfill(googleUser.authentication.accessToken)
        } else {
            pending.reject(AuthErrors.signInGoogleFailed)
        }
        
        return pending.promise
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

extension YTAuthService: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            return
        }
        
        let accesToken = user.authentication.accessToken
    }
}
