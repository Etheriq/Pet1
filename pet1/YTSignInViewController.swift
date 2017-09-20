//
//  YTSignInViewController.swift
//  pet1
//
//  Created by Yuriy T on 18.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit

protocol YTSignInViewControllerCoordinatorDelegate: class {
    func loginTapped()
}

class YTSignInViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    weak var coordinatorDelegate: YTSignInViewControllerCoordinatorDelegate?
    var presenter: YTSignInPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = YTSignInPresenter(withViewController: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Actions
    @IBAction func loginAction(_ sender: UIButton) {
        if presenter.validateLogin() {
            presenter?.makeLogin()
                .then { user -> Void in
                    
                // save user
                }
                .then { [weak self] _ in
                    self?.coordinatorDelegate?.loginTapped()
                }
                .catch { error in
                    // handle error
                }
        }
    }

}
