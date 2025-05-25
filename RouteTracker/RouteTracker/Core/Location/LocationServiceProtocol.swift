//
//  LocationServiceProtocol.swift
//  RouteTracker
//
//  Created by Can Bas on 25.05.2025.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol: AnyObject {
    var onLocationUpdate: ((CLLocation) -> Void)? { get set }
    func startTracking()
    func stopTracking()
    var currentLocation: CLLocation? { get }
    var isTracking: Bool { get }
}
