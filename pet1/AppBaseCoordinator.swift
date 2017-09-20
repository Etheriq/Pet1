//
//  AppBaseCoordinator.swift
//  pet1
//
//  Created by Yuriy T on 18.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit

class Coordinator {
    fileprivate var childCoordinators = [Coordinator]()
}

class AppBaseCoordinator: Coordinator {
    
    fileprivate let authService: YTAuthService
    fileprivate let navigationController: UINavigationController
    
    init(with navigationController: UINavigationController, andWithAuthService: YTAuthService) {
        self.navigationController = navigationController
        self.authService = andWithAuthService
        
    }
    
    deinit {
        debugPrint("deinit \(self)")
    }
    
    func start() {
        if authService.isAuthorized() {
            showHomeScreen()
        } else {
            showStartScreen()
        }
    }
    
    // Mark: - Coordinator actions
    fileprivate func showStartScreen() {
        let startCoordinator = YTAuthorizationFlowCoordinator(with: navigationController)
        startCoordinator.start()
        childCoordinators.append(startCoordinator)
    }
    
    fileprivate func showHomeScreen() {
        let tabBarCoordinator = YTTabbarCoordinator(with: navigationController)
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }
}

extension Coordinator {
    
    func removeChildCoordinator(coordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
    }
    func addChildCoordinator(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
    }
}
