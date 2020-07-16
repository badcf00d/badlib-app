//
//  CAGradientLayer.swift
//  Bad Lib
//
//  Created by Peter Frost on 15/12/2015.
//  Copyright © 2015 Peter Frost. All rights reserved.
//

import UIKit

extension CAGradientLayer {

    func lightBlueGradient() -> CAGradientLayer {

        let topColour = UIColor(red: 61/255, green: 140/255, blue: 244/255, alpha: 1)
        let bottomColour = UIColor(red: 21/255, green: 116/255, blue: 197/255, alpha: 1)
        let gradientColours = [topColour.cgColor, bottomColour.cgColor]
        let gradientLocators = [0.0, 1.0]
        
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColours
        gradientLayer.locations = gradientLocators as [NSNumber]?
        
        return gradientLayer
    }
    
    func GreyGradient() -> CAGradientLayer {
        
        let topColour = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        let bottomColour = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        let gradientColours = [topColour.cgColor, bottomColour.cgColor]
        let gradientLocators = [0.0, 1.0]
        
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColours
        gradientLayer.locations = gradientLocators as [NSNumber]?
        
        return gradientLayer
    }
    
    func Blank() -> CAGradientLayer {
        
        let topColour = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0)
        let bottomColour = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0)
        let gradientColours = [topColour.cgColor, bottomColour.cgColor]
        let gradientLocators = [0.0, 1.0]
        
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColours
        gradientLayer.locations = gradientLocators as [NSNumber]?
        
        return gradientLayer
    }
}
