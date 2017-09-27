//
//  YTHomeViewController.swift
//  pet1
//
//  Created by Yuriy T on 19.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit

protocol YTHomeViewControllerCoordinatorDelegate: class {
    func showSomethingTapped()
}

class YTHomeViewController: UIViewController {

    weak var coordinatorDelegate: YTHomeViewControllerCoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
