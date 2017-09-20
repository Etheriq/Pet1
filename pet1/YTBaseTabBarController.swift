//
//  YTBaseTabBarController.swift
//  pet1
//
//  Created by Yuriy T on 20.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit

protocol YTBaseTabBarControllerCoordinatorDelegate: class {
    func homeItemSelectedWith(navigationController: UINavigationController)
    func listItemSelectedWith(navigationController: UINavigationController)
    func settingsItemSelectedWith(navigationController: UINavigationController)
}

class YTBaseTabBarController: UITabBarController {

    weak var tabBarItemCoordinatorDelegate: YTBaseTabBarControllerCoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        
        let tabItems: [UITabBarItem] = [
            UITabBarItem(title: "Home", image: nil, selectedImage: nil),
            UITabBarItem(title: "List", image: nil, selectedImage: nil),
            UITabBarItem(title: "Settings", image: nil, selectedImage: nil)
        ]
        viewControllers = tabItems.map({
            let navVC = UINavigationController()
            navVC.tabBarItem = $0
            
            return navVC
        })
        
        if let navVC = viewControllers?.first as? UINavigationController {
            tabBarItemCoordinatorDelegate?.homeItemSelectedWith(navigationController: navVC)
        }
    }
}

// MARK: - UITabBarControllerDelegate
extension YTBaseTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }
        
        switch selectedIndex {
        case 0: tabBarItemCoordinatorDelegate?.homeItemSelectedWith(navigationController: controller)
        case 1: tabBarItemCoordinatorDelegate?.listItemSelectedWith(navigationController: controller)
        case 2: tabBarItemCoordinatorDelegate?.settingsItemSelectedWith(navigationController: controller)
            
        default: break
        }
    }
}
