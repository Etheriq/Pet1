//
//  DropDownOption.swift
//  pet1
//
//  Created by Yuriy T on 22.11.2017.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import Foundation

struct DropDownOption {
    let title: String
    let value: Int
}

extension DropDownOption: DropDownOptionsProtocol {
    func dropDownOptionTitle() -> String {
        return title
    }
    func dropDownOptionValue() -> Int {
        return value
    }
}
