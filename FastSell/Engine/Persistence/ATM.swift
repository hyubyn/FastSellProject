//
//  ATM.swift
//  FastSell
//
//  Created by HYUBYN on 4/6/16.
//  Copyright © 2016 hyubyn. All rights reserved.
//

import Foundation
import RealmSwift
import CoreLocation
import MapKit

final class ATM: Persistence {
    dynamic var name = ""
    dynamic var address = ""
    dynamic var lat = ""
    dynamic var lng = ""
    
    func kmDistanceFromCoordinate(coordinate: CLLocationCoordinate2D) -> Double {
        let longtitude = Double(lng)!
        let latitude = Double(lat)!
        let dlon = deg2rad(longtitude - coordinate.longitude)
        let dlat = deg2rad(latitude - coordinate.latitude)
        let a = (pow(sinf(dlat / 2), 2) + cosf(deg2rad(latitude))) * cosf(deg2rad(coordinate.latitude)) * pow(sinf(dlon / 2), 2)
        let angle = 2 * asin(sqrt(a))
        return Double(angle) * 6371
    }
    
    private func deg2rad(deg: Double) -> Float {
        return Float(deg * (M_PI/180))
    }
}

extension ATM: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lng)!)
    }
    
    var title: String? {
        return address
    }
    
    var subtitle: String? {
        return name
    }
}