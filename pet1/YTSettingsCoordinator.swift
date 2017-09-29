//
//  YTSettingsCoordinator.swift
//  pet1
//
//  Created by Yuriy T on 27.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit

class YTSettingsCoordinator: Coordinator {
    fileprivate let navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        debugPrint("deinit \(self)")
    }
    
    func start() {
        showSettings()
    }
    
    // MARK: - Coordinator actions
    fileprivate func showSettings() {
        let settingsVC = YTSettingsViewController.controllerInStoryboard(.settings)
        settingsVC.coordinatorDelegate = self
        
        navigationController.show(settingsVC, sender: self)
    }
    
    fileprivate func showProfile() {
        
    }
    fileprivate func showNotifications() {
        
    }
}

extension YTSettingsCoordinator: YTSettingsViewControllerCoordinatorDelegate {
    func showProfileTapped() {
        showProfile()
    }
    func showNotificationsTapped() {
     showNotifications()
    }
}
