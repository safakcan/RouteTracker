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

    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Route Tracker"
        setupBindings()
    }

    private func setupBindings() {
        customView.onStartTap = { [weak self] in
            guard let self = self else { return }
            print("Start tracking tapped")
        }

        customView.onDeleteTap = { [weak self] in
            guard let self = self else { return }
            print("Delete route tapped")
        }
    }

    private func updateTrackingLabel(isTracking: Bool, address: String?) {
        let title = isTracking ? "Tracking On" : "Tracking Off"
        let addressLine = address ?? "–"
        customView.trackingInfoLabel.text = "\(title)\n\(addressLine)"
    }

}
