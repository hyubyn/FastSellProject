//
//  SearchATMViewController.swift
//  FastSell
//
//  Created by HYUBYN on 4/6/16.
//  Copyright © 2016 hyubyn. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SearchATMViewController: UIViewController {
    var searchController : UISearchController!
    private let searchViewModel = SearchATMViewModel()
    private var currentCoordinate = CLLocationCoordinate2D()
    @IBOutlet weak var mapView: MKMapView!
    private var isFirstShow = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        searchController = UISearchController(searchResultsController:  nil)
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = NSLocalizedString("Input name to search", comment: "")
        navigationItem.titleView = searchController.searchBar
        LocationManager.sharedInstance.delegate = self
        definesPresentationContext = true
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    private func drawOnMap() {
        if searchViewModel.listATMInRange.count == 0 {
            AppUtils.showAlert("No ATM Found", message: "We found 0 ATM in radius of 20km, please add ATM first!", viewController: self)
        } else {
            for atm in searchViewModel.listATMInRange {
                mapView.addAnnotation(atm as! ATM)
            }
            let highestRadius = searchViewModel.highestRadius * 1000
            let circle = MKCircle(centerCoordinate: currentCoordinate, radius: highestRadius as CLLocationDistance)
            if highestRadius > 2000 {
            mapView.region = MKCoordinateRegionMakeWithDistance(currentCoordinate, highestRadius, highestRadius)
            }
            self.mapView.addOverlay(circle)
        }
    }
}

//MARK: LocationManagerDelegate
extension SearchATMViewController: LocationManagerDelegate {
    func didUpdateToLocation(location: CLLocation) {
        currentCoordinate = location.coordinate
        if !isFirstShow {
            isFirstShow = true
            mapView.region = MKCoordinateRegionMakeWithDistance(currentCoordinate, 2000, 2000)
        }
    }
}
//MARK: UISeachControllerDelegate
extension SearchATMViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchViewModel.startSearch(searchBar.text!, currentCoordinate: currentCoordinate)
        mapView.removeAnnotations(mapView.annotations)
        searchBar.endEditing(true)
        mapView.becomeFirstResponder()
        mapView.removeOverlays(mapView.overlays)
        drawOnMap()
    }
}

//MARK: MKMapViewDelegate
extension SearchATMViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ATM {
            let identifier = "pin"
            var view: MKPinAnnotationView
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.blueColor()
            circle.fillColor = UIColor(red: 0, green: 0, blue: 100, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        }
        return MKOverlayRenderer()
    }
}