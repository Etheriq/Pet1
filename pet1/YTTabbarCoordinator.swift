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
    var childCoordinators: [Coordinator] = []
    lazy var tabbar: YTBaseTabBarController = {
        let tabVC = YTBaseTabBarController.controllerInStoryboard(.tabbar)
        tabVC.tabBarItemCoordinatorDelegate = self

        return tabVC
    }()
    
    init (with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.navigationController.viewControllers = [tabbar]
    }
}

extension YTTabbarCoordinator: YTBaseTabBarControllerCoordinatorDelegate {
    func homeItemSelectedWith(navigationController: UINavigationController) {
        guard navigationController.viewControllers.isEmpty else { return }
        
        let homeCoordinator = YTHomeCoordinator(with: navigationController)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
//        addChildCoordinator(coordinator: homeCoordinator)
    }
    func listItemSelectedWith(navigationController: UINavigationController) {
        guard navigationController.viewControllers.isEmpty else { return }
        
        let listCoordinator = YTListCoordinator(with: navigationController)
        childCoordinators.append(listCoordinator)
        listCoordinator.start()
//        addChildCoordinator(coordinator: listCoordinator)
    }
    func settingsItemSelectedWith(navigationController: UINavigationController) {
        guard navigationController.viewControllers.isEmpty else { return }
        
        let settingsCoordinator = YTSettingsCoordinator(with: navigationController)
        childCoordinators.append(settingsCoordinator)
        settingsCoordinator.start()
//        addChildCoordinator(coordinator: settingsCoordinator)
    }
}
