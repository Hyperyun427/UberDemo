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
    //create share to access the same instance LoctionManager in anywhere
    static let shared = LocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
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
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updating")
        
        guard let location = locations.first else {return}
        userLocation = location.coordinate
        locationManager.stopUpdatingLocation()
    }
}
