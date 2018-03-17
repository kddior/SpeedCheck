//
//  WarningButton.swift
//  Speeding
//
//  Created by Serge Kone dossongui..
//  Copyright (c) 2014 skdossongui.com. All rights reserved.
//
//

import UIKit

/**
* Custom UIButton to set up the maximum speed.
*/

class WarningButton: UIButton {
    
    /**
    * Initializes the button. Sets up the border color, width and the font to be used for the button's title
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    /**
    * Initializes the button with a given frame. Sets up the border color, width and the font to be used for the button's title
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    /*
    * Sets up the border color, width and the font to be used for the button's title
    */
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        layer.borderColor = UIColor(white: 1.0, alpha: 0.8).cgColor
        layer.borderWidth = 2.0
        
        titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 30.0)
        titleLabel?.textAlignment = .center
        titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    /**
    * Lays out subviews, and set the button to be rounded
    */
    override func layoutSubviews() {
        layer.cornerRadius = bounds.height/2     //bounds.height
        super.layoutSubviews()
    }
}
