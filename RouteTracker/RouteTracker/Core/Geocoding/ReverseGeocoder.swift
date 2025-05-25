//
//  ReverseGeocoder.swift
//  RouteTracker
//
//  Created by Can Bas on 25.05.2025.
//

import Foundation
import CoreLocation

final class ReverseGeocoder: ReverseGeocoderProtocol {
    private let geocoder = CLGeocoder()

    func reverseGeocode(coord: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                let address = [placemark.name, placemark.locality, placemark.administrativeArea]
                    .compactMap { $0 }
                    .joined(separator: ", ")
                completion(address)
            } else {
                completion(nil)
            }
        }
    }
}
