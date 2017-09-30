//
//  Dictionary+Extension.swift
//  pet1
//
//  Created by Yuriy T on 30.09.2017.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
