//
//  OnboardingViewController.swift
//  RouteTracker
//
//  Created by Can Bas on 24.05.2025.
//

import UIKit

import UIKit

final class OnboardingViewController: UIViewController {
    private var viewModel: OnboardingViewModelProtocol
    private let customView = OnboardingView()

    init(viewModel: OnboardingViewModelProtocol) {
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
        self.setupBindings()
        customView.titleLabel.text = viewModel.welcomeText
        customView.descriptionLabel.text = viewModel.descriptionText
    }

    private func setupBindings() {
        viewModel.didUpdatePermissionStatus = { [weak self] status in
            DispatchQueue.main.async {
                  self?.handlePermissionStatus(status)
              }
        }

        customView.onAllowTap = { [weak self] in
            guard let self = self else { return }

             let status = self.viewModel.permissionStatus

             if status == .notDetermined {
                 self.viewModel.requestPermission()
             } else {
                 self.handlePermissionStatus(status)
             }
        }
    }

    private func handlePermissionStatus(_ status: LocationPermissionStatus) {
        switch status {
        case .authorized:
            transitionToMapScene()
        case .denied:
            showLocationDeniedAlert()
        default:
            break
        }
    }

    private func transitionToMapScene() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }

        let viewModel = MapTrackingViewModel(
            locationService: LocationService(),
            geocoder: ReverseGeocoder(),
            persistence: PersistenceManager()
        )

        let mapVC = MapTrackingViewController(viewModel: viewModel)
        window.rootViewController = mapVC
        UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: {}, completion: nil)
    }


    private func showLocationDeniedAlert() {
        let alert = UIAlertController(
            title: "Location Access Denied",
            message: "To use this app, please allow location access in Settings.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString),
                  UIApplication.shared.canOpenURL(settingsURL) else {
                return
            }
            UIApplication.shared.open(settingsURL)
        })

        present(alert, animated: true)
    }

}

