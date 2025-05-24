//
//  PermissionServiceProtocol.swift
//  RouteTracker
//
//  Created by Can Bas on 24.05.2025.
//

import Foundation
import CoreLocation

enum LocationPermissionStatus {
    case notDetermined
    case authorized
    case denied
}

protocol PermissionServiceProtocol {
    var status: LocationPermissionStatus { get }
    func requestAuthorization()
    var didChangeStatus: ((LocationPermissionStatus) -> Void)? { get set }
}

