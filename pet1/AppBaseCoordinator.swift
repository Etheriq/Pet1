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
        debugPrint("Base AppCoordinator deinit")
    }
    
    func start() {
        if authService.isAuthorized() {
            showHomeScreen()
        } else {
            showStartScreen()
        }
    }
    
    // Mark: - Coordinator actions
    private func showStartScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let startVC = storyboard.instantiateViewController(withIdentifier: "YTFirstStartViewController") as! YTFirstStartViewController
        
        
        navigationController.show(startVC, sender: self)
    }
    
    private func showHomeScreen() {
        
    }
    
}

extension Coordinator {
    
    fileprivate func removeChildCoordinator(coordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
    }
    
    fileprivate func addChildCoordinator(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
    }
}
