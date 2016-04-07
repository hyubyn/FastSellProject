//
//  LocationManager.swift
//  FastSell
//
//  Created by HYUBYN on 4/6/16.
//  Copyright © 2016 hyubyn. All rights reserved.
//

import CoreLocation

protocol LocationManagerDelegate: class {
    func didUpdateToLocation(location: CLLocation)
}

final class LocationManager: NSObject, CLLocationManagerDelegate {
    static let sharedInstance = LocationManager()
    let manager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager {
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        delegate?.didUpdateToLocation(newLocation)
    }
}