//
//  CompassButton.swift
//  Speeding
//
//  Created by Serge Kone dossongui..
//  Copyright (c) 2014 skdossongui.com. All rights reserved.
//
//

import UIKit
import CoreLocation

/**
* Custom UIButton that holds an arrow icon to show the direction of the true north direction
*/

class CompassButton: UIButton {

    // the arrow icon to show the true north direction, like in a compass
    let arrowIcon: UIImageView

    /**
    * Init method.
    * @param: coder NSCoder object
    */
    required init?(coder aDecoder: NSCoder) {
        arrowIcon = UIImageView()
        super.init(coder: aDecoder)
    }

    /**
    * Sets the new direction, and rotates the arrow
    * @param: newDirection - the new direction object
    */
    func setCompassDirection(newDirection: CLLocationDirection) {
        arrowIcon.transform = CGAffineTransform(rotationAngle: CGFloat(newDirection * Double.pi / 180))
    }
    
    /**
    * Sets up the arrowIcon imageView and rounds the view, and sets the border width and color
    */
    override func awakeFromNib() {
        arrowIcon.image = UIImage(named: "compassIcon")
        arrowIcon.frame =  CGRect.init(x: 0.0, y: 0.0, width: 0.9, height: 19.0)//CGRectMake(0.0, 0.0, 9.0, 19.0)
        arrowIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(arrowIcon)
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: arrowIcon, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: arrowIcon, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        layer.cornerRadius =  arrowIcon.bounds.width/2  // CGRectGetWidth(bounds)/2
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.white.cgColor
        super.awakeFromNib()
    }
    
}
