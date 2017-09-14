//
//  YTApiKey.swift
//  pet1
//
//  Created by Yuriy T on 14.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import Foundation
import FXKeychain

class YTKeychainHelper {
    
    private init() {}
    
    static var deviceID: String? {
        if let deviceId = FXKeychain.default().object(forKey: Constants.keyDeviceID) as? String {
            
            return deviceId
        } else {
            let deviceId = UIDevice.current.identifierForVendor?.uuidString
            FXKeychain.default().setObject(deviceId, forKey: Constants.keyDeviceID)
            
            return deviceId
        }
    }
    
    class func setPushToken(token: String) {
        FXKeychain.default().setObject(token, forKey: Constants.keyPushToken)
    }
    class func getPushToken() -> String? {
        let pushToken = FXKeychain.default().object(forKey: Constants.keyPushToken) as? String
        
        return pushToken
    }
    
    class func setApiToken(token: String) {
        FXKeychain.default().setObject(token, forKey: Constants.keyApiToken)
    }
    class func getApiToken() -> String? {
        let apiToken = FXKeychain.default().object(forKey: Constants.keyApiToken) as? String
        
        return apiToken
    }
    class func clearApiToken() {
        FXKeychain.default().removeObject(forKey: Constants.keyApiToken)
    }
}
