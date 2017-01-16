//
//  LocationManager.swift
//  FaceSnap
//
//  Created by James Estrada on 11/01/2017.
//  Copyright © 2017 James Estrada. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder() //used for the reverseGeocodeLocation to represent a user friendly coordinate (street, city, state, country)
    
    var onLocationFix: ((CLPlacemark?, NSError?) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
        getPermission()
    }
    
    private func getPermission() {
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Unresolved error \(error) \(error.userInfo)")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let onLocationFix = self.onLocationFix {
                onLocationFix(placemarks?.first, error)
            }
        }
    }
}