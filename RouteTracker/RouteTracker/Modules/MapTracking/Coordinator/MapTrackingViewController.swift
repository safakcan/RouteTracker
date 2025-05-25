//
//  MapTrackingViewController.swift
//  RouteTracker
//
//  Created by Can Bas on 25.05.2025.
//

import Foundation
import UIKit
import MapKit

final class MapTrackingViewController: UIViewController {
    private let customView = MapTrackingView()
    private let viewModel: MapTrackingViewModelProtocol

    init(viewModel: MapTrackingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        customView.mapView.delegate = self
        updateTrackingUI()
        viewModel.restorePersistedPins()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let coordinate = viewModel.currentLocation {
            centerMap(on: coordinate)
        }
    }

    private func centerMap(on coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 300,
            longitudinalMeters: 300
        )
        customView.mapView.setRegion(region, animated: true)
    }



    private func bindViewModel() {
        viewModel.onTrackingStateChanged = { [weak self] isTracking in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateTrackingUI()
            }
        }

        viewModel.onPinAdded = { [weak self] coordinate in
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            DispatchQueue.main.async {
                self?.customView.mapView.addAnnotation(pin)
            }
            self?.viewModel.reverseLookup(coordinate: coordinate)
        }


        viewModel.onAddressUpdated = { [weak self] address in
            DispatchQueue.main.async {
                self?.customView.trackingInfoLabel.text = "📍 \(address)"
            }
        }

        viewModel.onInitialLocation = { [weak self] coordinate in
            self?.centerMap(on: coordinate)
        }

        customView.onStartTap = { [weak self] in
            guard let self = self else { return }
            self.viewModel.toggleTracking()
            self.updateTrackingUI()
        }

        customView.onDeleteTap = { [weak self] in
            guard let self = self else { return }
            self.viewModel.deleteAllPins()
            self.customView.mapView.removeAnnotations(self.customView.mapView.annotations)
            updateTrackingUI()
        }

        customView.onCenterTap = { [weak self] in
            guard let coordinate = self?.viewModel.currentLocation else { return }
            self?.centerMap(on: coordinate)
        }

    }

    private func updateTrackingUI() {
        let tracking = viewModel.isCurrentlyTracking
        customView.startButton.setTitle(tracking ? "Stop" : "Start", for: .normal)
        customView.trackingInfoLabel.text = tracking ? "Tracking On\n–" : "Tracking Off\n–"
    }


}

extension MapTrackingViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let coordinate = view.annotation?.coordinate else { return }
        viewModel.reverseLookup(coordinate: coordinate)
    }
}
