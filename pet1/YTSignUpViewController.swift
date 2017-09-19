//
//  YTSignUpViewController.swift
//  pet1
//
//  Created by Yuriy T on 19.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit

protocol YTSignUpViewControllerDelegate: class {
    func registered()
}

class YTSignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    weak var coordinatorDelegate: YTSignUpViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Actions
    @IBAction func registrationAction(_ sender: UIButton) {
        registered()
    }
    
    // this must be into signUp presenter
    func registered() {
        coordinatorDelegate?.registered()
    }
    
    
}
