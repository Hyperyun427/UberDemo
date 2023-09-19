//
//  LocationManager.swift
//  UberDemo
//
//  Created by Yun Huang on 2023-09-17.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject{
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate{
    //everytime user update location, will call locationManager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]) {
        print("Location updating")
        
        guard !location.isEmpty else {return}
        locationManager.stopUpdatingLocation()
    }
}
