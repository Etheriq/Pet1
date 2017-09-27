//
//  YTListViewController.swift
//  pet1
//
//  Created by Yuriy T on 27.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit

protocol YTListViewControllerCoordinatorDelegate: class {
    func showListItem(withItem: String)
}

class YTListViewController: UIViewController {

    weak var coordinatorDelegate: YTListViewControllerCoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
