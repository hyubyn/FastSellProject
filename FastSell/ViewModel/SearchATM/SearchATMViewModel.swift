//
//  SearchATMViewModel.swift
//  FastSell
//
//  Created by HYUBYN on 4/7/16.
//  Copyright © 2016 hyubyn. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

enum RadiusLevel: Double {
    case Level1 = 1
    case Level2 = 2
    case Level3 = 4
    case Level4 = 6
    case Level5 = 8
    case Level6 = 10
    case Level7 = 12
    case Level8 = 20
    case Level9 = 21
    func nextLevel() -> RadiusLevel {
        switch self {
        case .Level1: return .Level2
        case .Level2: return .Level3
        case .Level3: return .Level4
        case .Level4: return .Level5
        case .Level5: return .Level6
        case .Level6: return .Level7
        case .Level7: return .Level8
        default: return .Level9
        }
    }
}
final class SearchATMViewModel {
    var listATMInRange = NSMutableArray()
    var highestRadius = Double(0)
    func startSearch(name: String, currentCoordinate: CLLocationCoordinate2D) {
        listATMInRange.removeAllObjects()
        do {
            let realm = try Realm()
            let listATM = realm.objects(ATM).filter("name CONTAINS '\(name.uppercaseString)'")
            var startRadius = RadiusLevel.Level1
            while startRadius.rawValue <= RadiusLevel.Level8.rawValue && listATMInRange.count < 1 {
                for atm in listATM {
                    let distance = atm.kmDistanceFromCoordinate(currentCoordinate)
                    if distance <= startRadius.rawValue {
                        listATMInRange.addObject(atm)
                    }
                    highestRadius = highestRadius > distance ? highestRadius : distance
                }
                startRadius = startRadius.nextLevel()
            }
        } catch let error as NSError {
            print(error)
        }
    }
}
