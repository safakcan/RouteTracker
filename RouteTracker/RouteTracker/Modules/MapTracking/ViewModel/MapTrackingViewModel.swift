//
//  MapTrackingViewModel.swift
//  RouteTracker
//
//  Created by Can Bas on 25.05.2025.
//

import Foundation
import Foundation
import CoreLocation

final class MapTrackingViewModel: MapTrackingViewModelProtocol {

    // MARK: - Outputs
    var onPinAdded: ((CLLocationCoordinate2D) -> Void)?
    var onAddressUpdated: ((String) -> Void)?
    var onTrackingStateChanged: ((Bool) -> Void)?

    var onInitialLocation: ((CLLocationCoordinate2D) -> Void)?
    private var hasSentInitialLocation = false

    var isCurrentlyTracking: Bool {
        return locationService.isTracking
    }

    var currentLocation: CLLocationCoordinate2D? {
        return locationService.currentLocation?.coordinate
    }

    // MARK: - Dependencies
    private let locationService: LocationServiceProtocol
    private let geocoder: ReverseGeocoderProtocol
    private let persistence: PersistenceManagerProtocol

    // MARK: - State
    private var isTracking = true
    private var lastRecordedLocation: CLLocation?
    private var trackedLocations: [CLLocationCoordinate2D] = []

    init(
        locationService: LocationServiceProtocol,
        geocoder: ReverseGeocoderProtocol,
        persistence: PersistenceManagerProtocol
    ) {
        self.locationService = locationService
        self.geocoder = geocoder
        self.persistence = persistence

        locationService.onLocationUpdate = { [weak self] location in
            self?.handleLocationUpdate(location)
        }

    }

    func toggleTracking() {
        isTracking.toggle()

        if isTracking {
            locationService.startTracking()
        } else {
            locationService.stopTracking()
        }

        onTrackingStateChanged?(isTracking)
    }


    func deleteAllPins() {
        trackedLocations.removeAll()
        persistence.clear()
        lastRecordedLocation = nil
        isTracking = false
        locationService.stopTracking()
        onTrackingStateChanged?(false)
    }

    func restorePersistedPins() {
        self.trackedLocations = persistence.loadCoordinates()
        self.trackedLocations.forEach { coord in
            self.onPinAdded?(coord)
        }

        if let last = trackedLocations.last {
            geocoder.reverseGeocode(coord: last) { [weak self] address in
                self?.onAddressUpdated?("👣 \(address ?? "-")")
            }
        }
    }

    func reverseLookup(coordinate: CLLocationCoordinate2D) {
        geocoder.reverseGeocode(coord: coordinate) { [weak self] address in
            self?.onAddressUpdated?(address ?? "Unknown")
        }
    }

    func updateCurrentUserLocationLabel() {
        guard let current = locationService.currentLocation else { return }

        geocoder.reverseGeocode(coord: current.coordinate) { [weak self] address in
            if let address = address {
                self?.onAddressUpdated?("👣 \(address)")
            }
        }
    }

    private func handleLocationUpdate(_ newLocation: CLLocation) {
        if !hasSentInitialLocation {
            hasSentInitialLocation = true
            onInitialLocation?(newLocation.coordinate)
        }

        guard let last = lastRecordedLocation else {
            save(location: newLocation)
            return
        }

        if newLocation.distance(from: last) >= 100 {
            save(location: newLocation)
        }

        updateCurrentUserLocationLabel()
    }

    private func save(location: CLLocation) {
        let coord = location.coordinate
        trackedLocations.append(coord)
        persistence.save(coordinate: coord)
        onPinAdded?(coord)
        lastRecordedLocation = location

        geocoder.reverseGeocode(coord: coord) { [weak self] address in
            self?.onAddressUpdated?(address ?? "Unknown address")
        }
    }

}
