//
//  YTFirstStartViewController.swift
//  pet1
//
//  Created by Yuriy T on 18.09.17.
//  Copyright © 2017 xeon.pet1.education. All rights reserved.
//

import UIKit

class YTFirstStartViewController: UIViewController {

    @IBOutlet weak var gradientedBackgroundView: YTGradientedView!
    @IBOutlet weak var logoImage: UIImageView!
    
    var colorArray: [(color1: UIColor, color2: UIColor)] = []
    var currentColorIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureGradientColors()
        animateGradientColors()
    }
    
    // MARK: - UI
    func configureGradientColors() {
        colorArray.append((color1: #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1), color2: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.8878869623, green: 0.1936300621, blue: 0.8867147724, alpha: 1), color2: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), color2: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), color2: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
    }
    
    func animateGradientColors() {
        currentColorIndex = currentColorIndex == (colorArray.count - 1) ? 0 : currentColorIndex + 1
        UIView.transition(with: gradientedBackgroundView,
                          duration: 2,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.gradientedBackgroundView.firstColor = self.colorArray[self.currentColorIndex].color1
                            self.gradientedBackgroundView.secondColor = self.colorArray[self.currentColorIndex].color2
        }) { (success) in
            self.animateGradientColors()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func signInAction(_ sender: UIButton) {
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
    }
    
    @IBAction func signInWithFacebookAction(_ sender: UIButton) {
    }

}
