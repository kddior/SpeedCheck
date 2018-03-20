//
//  LocationHandler.swift
//  Speeding
//
//  Created by Serge Kone dossongui..
//  Copyright (c) 2014 skdossongui.com. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

/**
* Custom protocol to share the location, speed and heading information with other classes that implements this protocol
*/

@objc protocol LocationHandlerProtocol {
    /**
    * Returns the speed and the current location objects
    * @param: speed - current speed of the user
    * @param: location - current location of the user
    */
    func locationHandlerDidUpdateLocationWithSpeed(speed: Double, location: CLLocation)
    /**
    * Return the current heading direction of the user
    * @param: newHeading - the new heading data to set the compass' direction
    */
    @objc optional func locationHandlerDidUpdateHeading(newHeading: CLHeading)
    

}

/**
* Custom object to handle location and heading events.
*/

class LocationHandler: NSObject, CLLocationManagerDelegate, MKMapViewDelegate {

    var locationHandlerProtocol: LocationHandlerProtocol?
    var locationManager: CLLocationManager!
    var currentUserLocation: CLLocation?
    
    /**
    * Initializer of the class.
    */
    override init() {
        locationManager = CLLocationManager()
        super.init()
        setupLocationHandler()
    }
    
    /**
    * Sets up the location manager and its properties
    */
    private func setupLocationHandler() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.headingFilter = kCLHeadingFilterNone
    }
    
  
    /**
    * Starts the location tracking
    */
    func startLocationTracking() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
    }
    
    /**
    * Tells the delegate that the location manager received updated heading information.
    * @param: manager - The location manager object that generated the update event.
    * @param: newHeading
    */
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        locationHandlerProtocol?.locationHandlerDidUpdateHeading?(newHeading: newHeading)
    }
    
    /**
    * Tells the delegate that new location data is available. If the speed is bigger than zero, call the protocol method to let 
    * other classes know of the new data available
    * @param: manager - The location manager object that generated the update event.
    * @param: locations - An array of CLLocation objects containing the location data
    */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first
        {
            let speed = firstLocation.speed
            if speed > 0 {
                locationHandlerProtocol?.locationHandlerDidUpdateLocationWithSpeed(speed: speed * 3.6, location: firstLocation)

            }
        }
        currentUserLocation = locations.first
    }

    /**
    * Asks the delegate whether the heading calibration alert should be displayed.
    * @param: manager - The location manager object coordinating the display of the heading calibration alert.
    * @return: Bool - Yes, if it should display the calibration
    */
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
}
