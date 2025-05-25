//
//  ReverseGeocoderProtocol.swift
//  RouteTracker
//
//  Created by Can Bas on 25.05.2025.
//

import Foundation
import CoreLocation

protocol ReverseGeocoderProtocol {
    func reverseGeocode(coord: CLLocationCoordinate2D, completion: @escaping (String?) -> Void)
}
