//
//  UIViewController+Extension.swift
//  pet1
//
//  Created by Yuriy T on 20.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit

extension UIViewController {
    private class func instantiateControllerInStoryboard<T: UIViewController>(_ storyboard: UIStoryboard, identifier: String) -> T {
        guard let vc = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("ViewController with identifier \"\(T.className)\" can't be cast to class: \(T.className)")
        }
        return vc
    }
    
    class func controllerInStoryboard(_ storyboard: YTStoryboards, identifier: String) -> Self {
        return instantiateControllerInStoryboard(UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main), identifier: identifier)
    }
    
    class func controllerInStoryboard(_ storyboard: YTStoryboards) -> Self {
        return controllerInStoryboard(storyboard, identifier: className)
    }
}
