//
//  MapTrackingViewModelProtocol.swift
//  RouteTracker
//
//  Created by Can Bas on 25.05.2025.
//

import Foundation
import CoreLocation

protocol MapTrackingViewModelProtocol: AnyObject {
    var onPinAdded: ((CLLocationCoordinate2D) -> Void)? { get set }
    var onAddressUpdated: ((String) -> Void)? { get set }
    var onTrackingStateChanged: ((Bool) -> Void)? { get set }
    var isCurrentlyTracking: Bool { get }
    var currentLocation: CLLocationCoordinate2D? { get }
    var onInitialLocation: ((CLLocationCoordinate2D) -> Void)? { get set }

    func updateCurrentUserLocationLabel()


    func reverseLookup(coordinate: CLLocationCoordinate2D)
    func toggleTracking()
    func deleteAllPins()
}
