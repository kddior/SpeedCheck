//
//  GradientExtension.swift
//  Speeding
//
//  Created by Serge Kone dossongui..
//  Copyright (c) 2014 skdossongui.com. All rights reserved.
//
//

import UIKit

/**
* CAGradientLayer class extension to show the normal and warning gradient layers
*/

extension CAGradientLayer {
   
    /**
    * Creates a normal gradient layer with base colors
    * @param: frame frame to be used for the layer
    * @return: CAGradientLayer the created gradient layer
    */
    class func normalGradientLayer(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = CAGradientLayer.gradientColors(warning: false)
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }

    /**
    * Creates a warning gradient layer with warning colors
    * @param: frame frame to be used for the layer
    * @return: CAGradientLayer the created gradient layer
    */
    class func warningGradientLayer(frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = CAGradientLayer.gradientColors(warning: true)
        gradientLayer.locations = [0.0, 1.0]
        return gradientLayer
    }
    
    /**
    * Returns the array of colors to be used according to the warning boolean
    * @param: warning if YES warning colors will be used
    * @return: [AnyObject] array of colors
    */
    class func gradientColors(warning: Bool) -> [AnyObject] {
        var arrayOfColors: [AnyObject] = []
        if warning
        {
            let colorTop: AnyObject = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
            let colorBottom: AnyObject = UIColor(red: 255.0/255.0, green: 42.0/255.0, blue: 104.0/255.0, alpha: 1.0).cgColor
            arrayOfColors = [colorTop, colorBottom]
        }
        else
        {
            let colorTop: AnyObject = UIColor(red: 96.0/255.0, green: 185.0/255.0, blue: 54.0/255.0, alpha: 1.0).cgColor
            let colorBottom: AnyObject = UIColor(red: 91.0/255.0, green: 193.0/255.0, blue: 230.0/255.0, alpha: 1.0).cgColor
            arrayOfColors = [colorTop, colorBottom]
        }
        return arrayOfColors
    }
}
