//
//  ViewController.swift
//  Speeding
//
//  Created by Serge Kone dossongui..
//  Copyright (c) 2014 skdossongui.com. All rights reserved.
//

import UIKit
import QuartzCore
import CoreLocation
import MapKit
import Social

/**
* The main viewController to show the main UI of the app.
*/

class ViewController: UIViewController, LocationHandlerProtocol, SpeedDisplayViewProtocol {
    
// mapView to show the user's location

    // gradient background layer
    var gradientLayer = CAGradientLayer()
    // locationHanlder object to handle GPS data
    let locationHandler = LocationHandler()
    // maximum speed set by the user
    var maximumSpeed: Double?
    
    
    // button to open mapView
    @IBOutlet var mapButton: UIButton!
    // button to show the compass
    @IBOutlet var compassButton: CompassButton!
    // share button to share location via Facebook, twitter
    @IBOutlet var shareButton: UIButton!
    // custom view to display the current speed
    @IBOutlet var speedDisplayView: SpeedDisplayView!
    // maximum speed label that is shown if the user set the maximum speed
    @IBOutlet var maxSpeedLabel: UILabel!

    /**
    * Called when the map button is pressed, opens the mapViewController to show the user's location and speed on the map. Assign the new viewController
    * as the delegate of the locationHandler so we can display information on that view as well.
    */
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 
        if segue.identifier == "mapSegue"
        {
            let mapViewController = segue.destination as! MapViewController
     
          //  mapViewController.s = (locationHandler.currentUserLocation?.speed)!
            
            //locationHandler.locationHandlerProtocol = mapViewController
            
      //      mapViewController.dismissButton.setCurrentSpeed(speed: (locationHandler.currentUserLocation?.speed)!)
        // locationHandler.currentUserLocation?.speed
        
        }
    }
    
    
    
    
    @IBAction func SwitchToMapView(_ sender: Any) {
        
        self.performSegue(withIdentifier: "mapSegue", sender: self)
        
    }
    
    /**
    * Shows an actionsheet to share user's location and speed via Facebook or twitter.
    */
    @IBAction func shareSpeedViaSocialMedia() {
        let actionsheet = UIAlertController(title: "Share", message: "Share your speed and location", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Facebook", style: .default, handler: { (alertAction) -> Void in
            let socialComposerAvailable = SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
            if socialComposerAvailable
            {
                let socialComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                socialComposer?.setInitialText("") // Your message here
                self.present(socialComposer!, animated: true, completion: nil)
            }
            else
            {
                self.presentErrorAlertViewForSocialMedia()
            }
        }))
        actionsheet.addAction(UIAlertAction(title: "twitter", style: .default, handler: { (alertAction) -> Void in
            let socialComposerAvailable = SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)
            if socialComposerAvailable
            {
                let socialComposer = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                socialComposer?.setInitialText("") // Your message here
                self.present(socialComposer!, animated: true, completion: nil)
            }
            else
            {
                self.presentErrorAlertViewForSocialMedia()
            }
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionsheet, animated: true, completion: nil)
    }
    
    /**
    * Presents an alertView if there was an error while trying to share via Facebook or twitter
    */
    func presentErrorAlertViewForSocialMedia() {
        let alertView = UIAlertController(title: "Error", message: "You cannot post right now, check your settings.", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
    
    /**
    * Calls when the view is loaded into memory. We do custom setups for the view, setting up the gradient background, start location tracking, 
    and customizing buttons and texts.
    */
    override func viewDidLoad() {
        addGradientBackground()
        
        maximumSpeed = 240.0
        locationHandler.startLocationTracking()
        speedDisplayView.speedDisplayViewProtocol = self
        
        mapButton.layer.borderWidth = 1.0
        mapButton.layer.borderColor = UIColor.white.cgColor
        mapButton.layer.cornerRadius = ( mapButton.bounds.width)/2     //CGRectGetWidth(mapButton.bounds)/2

        shareButton.layer.borderWidth = 1.0
        shareButton.layer.borderColor = UIColor.white.cgColor
        shareButton.layer.cornerRadius = ( mapButton.bounds.width)/2 //CGRectGetWidth(mapButton.bounds)/2
        
        maxSpeedLabel.text = ""
        maxSpeedLabel.textColor = UIColor(white: 1.0, alpha: 0.4)
        super.viewDidLoad()
    }
    
    /**
    * Reassigns locationHandler's protocol to this class, so the UI is updated when a new location is delivered.
    */
    override func viewDidAppear(_ animated: Bool) {
        locationHandler.locationHandlerProtocol = self
        super.viewDidAppear(animated)
    }

    /**
    * Sets up a gradient layer as a background for the view.
    */
    func addGradientBackground() {
        gradientLayer = CAGradientLayer.normalGradientLayer(frame: view.frame)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    // SpeedDisplayView protocol
    /**
    * SpeedDisplayView protocol method. If a maximum speed is already set, remove it, if not, show an alertview and wait for the user's interaction to add the maximum speed. 
    * @param warningButton - the button that was pressed
    */
    func speedDisplayViewWarningButtonPressed(warningButton: WarningButton) {
    //    if maximumSpeed != nil
     //   {
      //      maximumSpeed = nil
     //       warningButton.setTitle("!", for: .normal)
     //       speedDisplayView.hideMaxSpeedMarker()
     //       maxSpeedLabel.text = ""
     //   }
       // else
       // {
            let alertView = UIAlertController(title: "Set maximum speed", message: "Set up a maximum speed to be alerted when your current speed passes it.", preferredStyle: .alert)
            alertView.addTextField { (textField: UITextField!) -> Void in
                textField.placeholder = "Max speed limit"
                textField.keyboardType = .numberPad
                textField.becomeFirstResponder()
            }
            alertView.addAction(UIAlertAction(title: "Set", style: .default, handler: { (alertAction) -> Void in
                if let textField = alertView.textFields?.first
                {
                    if let text = textField.text {
                        let maxSpeed: Double = (text as NSString).doubleValue
                        if maxSpeed > 0
                        {
                            self.speedDisplayView.showMaxSpeedMarkerAt(maxSpeed: maxSpeed)
                            self.maximumSpeed = maxSpeed
                            self.maxSpeedLabel.text = String(format: "Max speed %.0f km/h", maxSpeed)
                            
                            let alertController = UIAlertController(title: "Slow down", message: "slow down", preferredStyle: UIAlertControllerStyle.alert)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            }))
            alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertView, animated: true, completion: nil)
      //  }
    }
    
    /**
    * Sets the new direction value to the compass
    * @param: newHeading - new heading value
    */
    func locationHandlerDidUpdateHeading(newHeading: CLHeading) {
        compassButton.setCompassDirection(newDirection: newHeading.trueHeading)
    }
    
    /**
    * Displays the received speed value and checks if it is more than the maximum speed.
    * @param: speed - current speed
    * @param: location - current location
    */
    func locationHandlerDidUpdateLocationWithSpeed(speed: Double, location: CLLocation) {
        if speed > 0
        {
            let formattedSpeed: Double = speed
            speedDisplayView.setCurrentSpeed(speed: formattedSpeed)
            checkCurrentSpeedOverMaximumSpeed(currentSpeed: formattedSpeed)
        }
    }
    


    /**
    * Checks if the current speed is bigger then the maximum speed (if set), if YES, a different background gradient is used.
    */
    func checkCurrentSpeedOverMaximumSpeed(currentSpeed: Double) {
        if (currentSpeed >= maximumSpeed! && maximumSpeed != nil)
        {
            gradientLayer.colors = CAGradientLayer.gradientColors(warning: true)
        }
        else
        {
            gradientLayer.colors = CAGradientLayer.gradientColors(warning: false)
           
        }
    }
    
    
    /**
    * The preferred status bar style for the view controller. White in this case.
    */
  /*   override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }*/
}
