//
//  PersistenceManager.swift
//  RouteTracker
//
//  Created by Can Bas on 25.05.2025.
//

import Foundation
import CoreLocation

final class PersistenceManager: PersistenceManagerProtocol {
    private let key = "saved_coordinates"

    func save(coordinate: CLLocationCoordinate2D) {
        var coords = loadCoordinates()
        coords.append(coordinate)
        let array = coords.map { [$0.latitude, $0.longitude] }
        UserDefaults.standard.set(array, forKey: key)
        UserDefaults.standard.synchronize()
    }

    func loadCoordinates() -> [CLLocationCoordinate2D] {
        guard let saved = UserDefaults.standard.array(forKey: key) as? [[Double]] else {
            return []
        }
        return saved.map { CLLocationCoordinate2D(latitude: $0[0], longitude: $0[1]) }
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
