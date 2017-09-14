//
//  YTDatabase.swift
//  pet1
//
//  Created by Yuriy T on 14.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import Foundation
import RealmSwift

class YTDatabase {
    
    static let currentSchemaVersion = UInt64(1)
    static let shared = YTDatabase()
    private init() {}
    
    var defaultRealm: Realm {
        get {
            return try! Realm()
        }
    }
    
    func initializeRealm() {
        var config = Realm.Configuration()
        config.schemaVersion = YTDatabase.currentSchemaVersion
        
        Realm.Configuration.defaultConfiguration = config
    }
}
