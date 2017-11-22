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
    @IBOutlet weak var dropDownButton: DropDownButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dropDownButton.dropDownView.dropDownOptions = [
            DropDownOption(title: "1 Option", value: 1),
            DropDownOption(title: "2 Option", value: 2),
            DropDownOption(title: "3 Option", value: 3),
            DropDownOption(title: "4 Option", value: 4),
            DropDownOption(title: "5 Option", value: 5),
            DropDownOption(title: "6 Option", value: 6),
            DropDownOption(title: "7 Option", value: 7),
            DropDownOption(title: "8 Option", value: 8)
        ]
        dropDownButton.selectedDelegate = self
    }
}

extension YTListViewController: DropDownSelectedOptionDelegate {
    func dropDownSelected(withItem: DropDownOptionsProtocol) {
        debugPrint("Selected Title: \(withItem.dropDownOptionTitle()) with value: \(withItem.dropDownOptionValue())")
    }
}

