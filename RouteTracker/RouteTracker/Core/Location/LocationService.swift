//
//  LocationService.swift
//  RouteTracker
//
//  Created by Can Bas on 25.05.2025.
//

import Foundation
import CoreLocation

final class LocationService: NSObject, LocationServiceProtocol {
    private let manager = CLLocationManager()
    private var lastLocation: CLLocation?

    var onLocationUpdate: ((CLLocation) -> Void)?
    var currentLocation: CLLocation? { lastLocation }
    private var trackingEnabled = true

    var isTracking: Bool {
        return trackingEnabled
    }


    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 10
        manager.allowsBackgroundLocationUpdates = true
        manager.pausesLocationUpdatesAutomatically = false
    }

    func startTracking() {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {

            trackingEnabled = true
            manager.startUpdatingLocation()
        } else {
            manager.requestAlwaysAuthorization()
        }
    }

    func stopTracking() {
        trackingEnabled = false
        manager.stopUpdatingLocation()
    }

}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let newLocation = locations.last else { return }
        lastLocation = newLocation
        onLocationUpdate?(newLocation)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            startTracking()
        }
    }
}
