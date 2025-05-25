//
//  OnboardingViewModel.swift
//  RouteTracker
//
//  Created by Can Bas on 24.05.2025.
//

import Foundation
import CoreLocation

protocol OnboardingViewModelProtocol {
    var welcomeText: String { get }
    var descriptionText: String { get }
    var didUpdatePermissionStatus: ((LocationPermissionStatus) -> Void)? { get set }
    var permissionStatus: LocationPermissionStatus { get }
    func requestPermission()
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    private var permissionService: PermissionServiceProtocol
    var didUpdatePermissionStatus: ((LocationPermissionStatus) -> Void)?

    init(permissionService: PermissionServiceProtocol) {
        self.permissionService = permissionService
        self.permissionService.didChangeStatus = { [weak self] status in
            self?.didUpdatePermissionStatus?(status)
        }
    }

    var permissionStatus: LocationPermissionStatus {
        return permissionService.status
    }

    var welcomeText: String {
        return "Track your route and mark places you pass"
    }

    var descriptionText: String {
        return "We need your permission to access location even in the background."
    }

    func requestPermission() {
        permissionService.requestWhenInUseAuthorization()
    }
}

