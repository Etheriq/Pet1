//
//  YTHomeCoordinator.swift
//  pet1
//
//  Created by Yuriy T on 27.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit

class YTHomeCoordinator: Coordinator {
    fileprivate let navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        debugPrint("deinit \(self)")
    }
    
    func start() {
        showHome()
    }

    // MARK: - Coordinator actions
    fileprivate func showHome() {
        let homeVC = YTHomeViewController.controllerInStoryboard(.home)
        homeVC.coordinatorDelegate = self
        
        navigationController.show(homeVC, sender: self)
    }
    
    fileprivate func showSomething() {
        
    }
}

extension YTHomeCoordinator: YTHomeViewControllerCoordinatorDelegate {
    func showSomethingTapped() {
        showSomething()
    }
}
