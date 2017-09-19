//
//  YTUser.swift
//  pet1
//
//  Created by Yuriy T on 19.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import RealmSwift

class YTUser: Object {
    dynamic var id = 0
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var dob = Date()
    dynamic var email = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
