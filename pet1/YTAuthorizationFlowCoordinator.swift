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
        let startVC = YTFirstStartViewController.controllerInStoryboard(.firstStart)
        startVC.coordinatorDelegate = self
        
        navigationController.show(startVC, sender: self)
    }
    
    // MARK: - Coordinator actions
    fileprivate func showSignIn() {
        let signInVC = YTSignInViewController.controllerInStoryboard(.signIn)
        signInVC.coordinatorDelegate = self
        
        navigationController.show(signInVC, sender: self)
    }
    fileprivate func showSignUp() {
        let signUpVC = YTSignUpViewController.controllerInStoryboard(.signUp)
        signUpVC.coordinatorDelegate = self
        
        navigationController.show(signUpVC, sender: self)
    }
    fileprivate func showSignInWithFB() {
        
    }
    fileprivate func showTermsAndCond(modal: Bool) {
        let termsVC = YTTermsAndConditionsViewController.controllerInStoryboard(.termsAndConditions)
        termsVC.coordinatorDelegate = self
        termsVC.isModalPresenting = modal
        
        if modal {
            let navVC = UINavigationController(rootViewController: termsVC)
            navigationController.present(navVC, animated: true, completion: nil)
        } else {
            navigationController.show(termsVC, sender: self)
        }
    }
    
    fileprivate func showHomeScreen() {
        removeChildCoordinator(coordinator: self)
        
        let tabBarCoordinator = YTTabbarCoordinator(with: navigationController)
        tabBarCoordinator.start()
        addChildCoordinator(coordinator: tabBarCoordinator)        
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
        showHomeScreen()
    }
    func showTermsAndConditionsTapped(modal: Bool) {
        showTermsAndCond(modal: true)
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

extension YTAuthorizationFlowCoordinator: YTTermsAndConditionsViewControllerCoordinatorDelegate {
    func applyTapped(vc: YTTermsAndConditionsViewController) {
        
    }
    func cancelTapped(vc: YTTermsAndConditionsViewController) {
        vc.dismiss(animated: true, completion: nil)
    }
}
































