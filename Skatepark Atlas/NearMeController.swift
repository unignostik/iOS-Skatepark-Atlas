//
//  NearMeController.swift
//  Skatepark Atlas
//
//  Created by Chase Tillar on 12/31/17.
//  Copyright © 2017 Chase Tillar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NearMeController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //outlets
    @IBOutlet weak var parkMap: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        enableLocationServices()
        setParkView()
        determineCurrentLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - CLLocationManager Delegates
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        //stop listening for location updates
        manager.stopUpdatingLocation()
        
        //center on user location
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        //show on parkMap
        self.parkMap.setRegion(region, animated: true)
        
        //print("user latitude = \(userLocation.coordinate.latitude)")
        //print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    // MARK: - User Instances
    
    //request location services if not enabled
    func enableLocationServices() {
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
        }
    }

    //set parkMap MapView layout
    func setParkView() {
        parkMap.mapType = MKMapType.standard
        parkMap.isZoomEnabled = true
        parkMap.isScrollEnabled = true
        parkMap.center = view.center
    }
    
    //get user location
    func determineCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}
