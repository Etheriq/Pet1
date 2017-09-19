//
//  FirstStartViewControllerCoordinator.swift
//  pet1
//
//  Created by Yuriy T on 18.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit

class YTAuthorizationFlowCoordinator: Coordinator {
    
    fileprivate let navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        debugPrint("deinit \(self)")
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "FirstStart", bundle: nil)
        let startVC = storyboard.instantiateViewController(withIdentifier: "YTFirstStartViewController") as! YTFirstStartViewController
        startVC.coordinatorDelegate = self
        
        navigationController.show(startVC, sender: self)
    }
    
    // MARK: - Coordinator ways
    fileprivate func showSignIn() {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: "YTSignInViewController") as! YTSignInViewController
        signInVC.coordinatorDelegate = self
        
        navigationController.show(signInVC, sender: self)
    }
    fileprivate func showSignUp() {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let signUpVC = storyboard.instantiateViewController(withIdentifier: "YTSignUpViewController") as! YTSignUpViewController
        signUpVC.coordinatorDelegate = self
        
        navigationController.show(signUpVC, sender: self)
    }
    fileprivate func showSignInWithFB() {
        
    }
    fileprivate func showTermsAndCond() {
        
    }
    
    func showHomeScreen() {
//        removeChildCoordinator(coordinator: self)
        
        // create home coordinator and make start()
// TODO: Think about this: maybe need clear navigation stack VC
    }
}

extension YTAuthorizationFlowCoordinator: YTFirstStartViewControllerCoordinatorDelegate {
    func signInTapped() {
        showSignIn()
    }
    func signUpTapped() {
        showSignUp()
    }
    func signInWithFBTapped() {
        showSignInWithFB()
    }
    func showTermsAndConditionsTapped() {
        showTermsAndCond()
    }
}

extension YTAuthorizationFlowCoordinator: YTSignUpViewControllerDelegate {
    func registered() {
        showHomeScreen()
    }
}

extension YTAuthorizationFlowCoordinator: YTSignInViewControllerCoordinatorDelegate {
    func loginTapped() {
        showHomeScreen()
    }
}


































