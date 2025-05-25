//
//  PersistenceManagerProtocol.swift
//  RouteTracker
//
//  Created by Can Bas on 25.05.2025.
//

import Foundation
import CoreLocation

protocol PersistenceManagerProtocol {
    func save(coordinate: CLLocationCoordinate2D)
    func loadCoordinates() -> [CLLocationCoordinate2D]
    func clear()
}
