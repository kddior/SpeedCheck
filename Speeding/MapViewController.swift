//
//  MapViewController.swift
//  Speeding
//
//  Created by Serge Kone dossongui..
//  Copyright (c) 2014 skdossongui.com. All rights reserved.
//
//

import UIKit
import MapKit

/**
* Custom UIViewController to show the user's location on the map and their current speed.
*/

class MapViewController: UIViewController, LocationHandlerProtocol {
    func locationHandlerDidUpdateHeading(newHeading: CLHeading) {
        print("test")
    }
    
    

    /// mapView to show the user's location
    @IBOutlet var mapView: MKMapView!
    // custom button that shows the user's speed and
    @IBOutlet var dismissButton: MapViewSpeedButton!
    // location handler's protocol to get updates of location events
    var locationHandlerProtocol: LocationHandlerProtocol?
    
    /**
    * Dismisses the view.
    */
    @IBAction func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    /**
    * Shows the location of the user on the map and sets the center of the mapView to the new location
    * @param: speed - current speed
    * @param: location - current location
    */
    func locationHandlerDidUpdateLocationWithSpeed(speed: Double, location: CLLocation) {
        mapView.setCenter(location.coordinate, animated: true)
        dismissButton.setCurrentSpeed(speed: speed)
        
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
        mapView.setRegion(region, animated: true)
    }
    
    
   

    
}
