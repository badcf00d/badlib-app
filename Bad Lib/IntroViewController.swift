//
//  ViewController2.swift
//  Bad Lib
//
//  Created by Peter Frost on 15/12/2015.
//  Copyright © 2015 Peter Frost. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    let waterimage = UIImage(named: "Water logo.png")! as UIImage
    let drinkimage = UIImage(named: "Drinking logo.png")! as UIImage
    let waterButton = UIButton(type: .system) as UIButton?
    let drinkButton = UIButton(type: .system) as UIButton?
    let hiddenButton = UIButton(type: .custom) as UIButton?
    let waterlabel = UILabel()
    let drinklabel = UILabel()
    var stopAnimating = false
    
    @IBAction func hiddenButton(_ sender: UIButton) {
        if stopAnimating {
        performSegue(withIdentifier: "Main", sender: nil)
        }
        stopAnimating = true
        self.animateWaterButtonDisappear()
        self.animateWaterlabelDisappear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drinkButton?.frame = CGRect(x: (self.view.center.x), y: (self.view.center.y - 80), width: 0, height: 0)
        drinkButton?.setBackgroundImage(drinkimage, for: UIControl.State())
        self.view.addSubview(drinkButton!)

        waterlabel.frame = CGRect(x: (0), y: (0), width: 400, height: 60)
        waterlabel.center = CGPoint(x: (self.view.center.x), y: (self.view.frame.size.height - 80))
        waterlabel.textAlignment = NSTextAlignment.center
        waterlabel.text = "Get a Drink"
        waterlabel.font = UIFont(name: "Avenir-Black", size: 45)
        waterlabel.textColor = UIColor.white
        self.view.addSubview(waterlabel)
        
        drinklabel.frame = CGRect(x: (0), y: (0), width: 400, height: 60)
        drinklabel.center = CGPoint(x: (self.view.center.x + 400), y: (self.view.frame.size.height - 80))
        drinklabel.textAlignment = NSTextAlignment.center
        drinklabel.text = "Take A Swig"
        drinklabel.font = UIFont(name: "Avenir-Black", size: 45)
        drinklabel.textColor = UIColor.white
        drinklabel.isHidden = true
        self.view.addSubview(drinklabel)
        
        waterButton?.frame = CGRect(x: (self.view.center.x - 150), y: (self.view.center.y - 220), width: 300, height: 300)
        waterButton?.setBackgroundImage(waterimage, for: UIControl.State())
        self.view.addSubview(waterButton!)
        
        hiddenButton?.frame = CGRect(x: (self.view.center.x - 150), y: (self.view.center.y - 220), width: 300, height: 300)
        hiddenButton?.addTarget(self, action: #selector(IntroViewController.hiddenButton(_:)), for:UIControl.Event.touchUpInside)
        self.view.addSubview(hiddenButton!)
        
        let background = CAGradientLayer().lightBlueGradient()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at:  0)
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.animateWaterButtonDown()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func animateWaterButtonUp() {
        UIView.animate(withDuration: 0.6, animations: {
            self.waterButton?.frame = CGRect(x: (self.view.center.x - 150), y: (self.view.center.y - 220), width: 300, height: 300)
            }, completion: { animationFinished in
                if animationFinished {
                    if !self.stopAnimating {
                        self.animateWaterButtonDown()
                    } else {
                        let layer = self.waterButton?.layer.presentation() as CALayer?
                        let frame = layer?.frame
                        self.waterButton?.layer.removeAllAnimations()
                        self.waterButton?.frame = frame!
                        self.animateWaterButtonDisappear()

                    }
                }
        })
    }
    
    func animateWaterButtonDown() {
        UIView.animate(withDuration: 0.6, animations: {
            self.waterButton?.frame = CGRect(x: (self.view.center.x - 140), y: (self.view.center.y - 210), width: 280, height: 280)
            }, completion: { animationFinished in
                if animationFinished {
                    if !self.stopAnimating {
                        self.animateWaterButtonUp()
                    } else {
                        let layer = self.waterButton?.layer.presentation() as CALayer?
                        let frame = layer?.frame
                        self.waterButton?.layer.removeAllAnimations()
                        self.waterButton?.frame = frame!
                        self.animateWaterButtonDisappear()
                        self.animateWaterlabelDisappear()
                    }
                }
        })
    }
    
    func animateDrinkButtonUp() {
        UIView.animate(withDuration: 1, animations: {
            self.drinkButton?.frame = CGRect(x: (self.view.center.x - 150), y: (self.view.center.y - 220), width: 300, height: 300)
            }, completion: { animationFinished in
                if animationFinished {
                        self.animateDrinkButtonDown()
                }
        })
    }
    
    func animateDrinkButtonDown() {
        UIView.animate(withDuration: 1, animations: {
            self.drinkButton?.frame = CGRect(x: (self.view.center.x - 140), y: (self.view.center.y - 210), width: 280, height: 280)
            }, completion: { animationFinished in
                if animationFinished {
                        self.animateDrinkButtonUp()
                }
        })
    }
    
    func animateWaterlabelDisappear() {
        UIView.animate(withDuration: 0.5, animations: {
            self.waterlabel.center = CGPoint(x: (self.view.center.x - 500), y: (self.view.frame.size.height - 80))
            self.waterlabel.alpha = 0.01
            }, completion: { animationFinished in
                if animationFinished {
                    self.animateDrinkLabelAppear()
                }
        })
    }
    
    func animateDrinkLabelAppear() {
        UIView.animate(withDuration: 0.5, animations: {
            self.drinklabel.isHidden = false
            self.drinklabel.frame = CGRect(x: (0), y: (0), width: 400, height: 60)
            self.drinklabel.center = CGPoint(x: (self.view.center.x), y: (self.view.frame.size.height - 80))
            }, completion: { animationFinished in
                if animationFinished {
                    print("Done")
                }
        })
    }


    
    func animateWaterButtonDisappear() {
        UIView.animate(withDuration: 0.3, animations: {
            self.waterButton?.frame = CGRect(x: (self.view.center.x), y: (self.view.center.y - 100), width: 0, height: 0)
            }, completion: { animationFinished in
                if animationFinished {
                    self.waterButton?.isHidden = true
                    self.animateDrinkButtonUp()
                }
        })
    }
    
}
