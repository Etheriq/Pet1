//
//  NSObject+Extension.swift
//  pet1
//
//  Created by Yuriy T on 20.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import Foundation

extension NSObject {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
