//
//  YTTabbarCoordinator.swift
//  pet1
//
//  Created by Yuriy T on 20.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit

class YTTabbarCoordinator: Coordinator {
    
    fileprivate let navigationController: UINavigationController
    fileprivate var tabbar: YTBaseTabBarController? {
        return navigationController.viewControllers.first as? YTBaseTabBarController
    }
    
    init (with navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.viewControllers = [YTBaseTabBarController.controllerInStoryboard(.tabbar)]
    }
    
    func start() {
        tabbar?.tabBarItemCoordinatorDelegate = self
    }
}

extension YTTabbarCoordinator: YTBaseTabBarControllerCoordinatorDelegate {
    func homeItemSelectedWith(navigationController: UINavigationController) {
        guard navigationController.viewControllers.isEmpty else { return }
        
        let homeCoordinator = YTHomeCoordinator(with: navigationController)
        homeCoordinator.start()
        addChildCoordinator(coordinator: homeCoordinator)
    }
    func listItemSelectedWith(navigationController: UINavigationController) {
        guard navigationController.viewControllers.isEmpty else { return }
        
        let listCoordinator = YTListCoordinator(with: navigationController)
        listCoordinator.start()
        addChildCoordinator(coordinator: listCoordinator)
    }
    func settingsItemSelectedWith(navigationController: UINavigationController) {
        guard navigationController.viewControllers.isEmpty else { return }
        
        let settingsCoordinator = YTSettingsCoordinator(with: navigationController)
        settingsCoordinator.start()
        addChildCoordinator(coordinator: settingsCoordinator)
    }
}
