//
//  ScrollPageViewController.swift
//  Bad Lib
//
//  Created by Peter Frost on 16/08/2017.
//  Copyright © 2017 Peter Frost. All rights reserved.
//

import UIKit

class ScrollPageViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var menuImage1: UIImageView!
    @IBOutlet weak var menuImage2: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeScreenView = storyboard.instantiateViewController(withIdentifier: "HomeScreen")
        let settingsScreenView = storyboard.instantiateViewController(withIdentifier: "SettingsScreen")
        let bounds = UIScreen.main.bounds
        let deviceWidth = bounds.size.width
        let deviceHeight = bounds.size.height
        let viewControllers = [homeScreenView, settingsScreenView]
        let menuImage1TapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let menuImage2TapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        var i = 0
        
        scrollView!.contentSize = CGSize(width: 2*deviceWidth, height: deviceHeight - (667 - scrollView.frame.width))
        scrollView!.delegate = self
        
        for viewController in viewControllers {
            addChild(viewController)
            let originX:CGFloat = CGFloat(i) * deviceWidth

            viewController.view.frame = CGRect(x: originX, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            
            scrollView!.addSubview(viewController.view)
            viewController.didMove(toParent: self)
            i += 1;
        }

        menuImage2.addGestureRecognizer(menuImage1TapRecognizer)
        menuImage1.addGestureRecognizer(menuImage2TapRecognizer)

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //375*0.5 = 375*0.93 - 375*x, x = 0.93 - 0.5 = 0.43
        let iconMarginFraction = (UIScreen.main.bounds.size.width - 20) / UIScreen.main.bounds.size.width
        let iconMoveAmount = scrollView.contentOffset.x * (iconMarginFraction - 0.5)
        let fractionMoved = scrollView.contentOffset.x / scrollView.frame.width
        let fadeFraction: CGFloat = 0.7
        let shrinkFraction: CGFloat = 0.2
        let originalSize: CGFloat = 25
        let iconYDist: CGFloat = 27.5

        menuImage1.alpha = 1 - (fractionMoved * fadeFraction)
        menuImage2.alpha = (1 - fadeFraction) + (fractionMoved * fadeFraction)
        
        //Sorry about these gross lines, lots of it is to change the x coordinate from the 
        //top-left to the centre of the image
        
        menuImage1.frame = CGRect(x: ((scrollView.frame.width * 0.5) - (menuImage1.frame.width * 0.5)) - iconMoveAmount, y: iconYDist + (iconYDist - menuImage1.frame.width), width: originalSize * (1 - (fractionMoved * shrinkFraction)), height: originalSize * (1 - (fractionMoved * shrinkFraction)))
        menuImage2.frame = CGRect(x: ((scrollView.frame.width * iconMarginFraction) - (menuImage2.frame.width * 0.5)) - iconMoveAmount, y: iconYDist + (iconYDist - menuImage2.frame.width), width: originalSize * ((1 - shrinkFraction) + (fractionMoved * shrinkFraction)), height: originalSize * ((1 - shrinkFraction) + (fractionMoved * shrinkFraction)))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        var moveToOffset = CGPoint.init(x: 0, y: 0)
        
        if (tappedImage.restorationIdentifier == "SettingsIcon") {
            moveToOffset.x = 375
        }
        
        scrollView.setContentOffset(moveToOffset, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
