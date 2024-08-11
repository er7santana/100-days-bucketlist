//
//  LocationFetcher.swift
//  BucketList
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 10/08/24.
//

import CoreLocation

protocol LocationFetcherDelegate: AnyObject {
    func didFindLocation(_ location: CLLocationCoordinate2D)
}

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    weak var delegate: LocationFetcherDelegate?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        if let lastKnownLocation {
            delegate?.didFindLocation(lastKnownLocation)
            manager.stopUpdatingLocation()
        }
    }
}
