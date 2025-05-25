//
//  PermissionService.swift
//  RouteTracker
//
//  Created by Can Bas on 24.05.2025.
//

import Foundation
import CoreLocation

final class PermissionService: NSObject, PermissionServiceProtocol {
    private let locationManager = CLLocationManager()
    var didChangeStatus: ((LocationPermissionStatus) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
    }

    var status: LocationPermissionStatus {
        switch locationManager.authorizationStatus {
        case .notDetermined: return .notDetermined
        case .authorizedWhenInUse: return .authorized
        case .authorizedAlways: return .authorized
        case .denied, .restricted: return .denied
        @unknown default: return .denied
        }
    }

    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func requestAlwaysAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
}


extension PermissionService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let currentStatus = status
        didChangeStatus?(currentStatus)

        if manager.authorizationStatus == .authorizedWhenInUse {
            print("Requesting Always Authorization")
            locationManager.requestAlwaysAuthorization()

            locationManager.startUpdatingLocation()
            locationManager.distanceFilter = 100
        }

        if manager.authorizationStatus == .authorizedAlways {
            print("✅ Always Granted — stopping location updates")
            locationManager.stopUpdatingLocation()
        }
    }

}

