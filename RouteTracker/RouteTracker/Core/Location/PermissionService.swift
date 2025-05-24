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
        case .notDetermined:
            return .notDetermined
        case .authorizedAlways:
            return .authorized
        case .authorizedWhenInUse:
            return .authorized
        case .denied, .restricted:
            return .denied
        @unknown default:
            return .denied
        }
    }

    func requestAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()

        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()

        default:
            break
        }
    }
}

extension PermissionService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        didChangeStatus?(status)

        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
}
