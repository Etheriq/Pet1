//
//  YTListCoordinator.swift
//  pet1
//
//  Created by Yuriy T on 27.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit

class YTListCoordinator: Coordinator {
    fileprivate let navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        debugPrint("deinit \(self)")
    }
    
    func start() {
        showList()
    }
    
    // MARK: - Coordinator actions
    fileprivate func showList() {
        let listVC = YTListViewController.controllerInStoryboard(.list)
        listVC.coordinatorDelegate = self
        
        navigationController.show(listVC, sender: self)
    }
    
    fileprivate func showListWithItem(withItem: String) {
        
    }
}

extension YTListCoordinator: YTListViewControllerCoordinatorDelegate {
    func showListItem(withItem: String) {
        showListWithItem(withItem: withItem)
    }
}
