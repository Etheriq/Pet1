//
//  YTTermsAndConditionsViewController.swift
//  pet1
//
//  Created by Yuriy T on 20.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit

protocol YTTermsAndConditionsViewControllerCoordinatorDelegate: class {
    func applyTapped(vc: YTTermsAndConditionsViewController)
    func cancelTapped(vc: YTTermsAndConditionsViewController)
}

class YTTermsAndConditionsViewController: UIViewController {

    var isModalPresenting: Bool!
    weak var coordinatorDelegate: YTTermsAndConditionsViewControllerCoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(applyButtonTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
    }
    
    // MARK: - Helpers
    func cancelButtonTapped() {
        coordinatorDelegate?.cancelTapped(vc: self)
    }
    
    func applyButtonTapped() {
        coordinatorDelegate?.applyTapped(vc: self)
//
//        if isModalPresenting {
//            dismiss(animated: true, completion: nil)
//        } else {
//            self.navigationController?.popViewController(animated: true)
//        }
    }
}
