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
        setupBindings()
        customView.titleLabel.text = viewModel.welcomeText
        customView.descriptionLabel.text = viewModel.descriptionText
    }

    private func setupBindings() {
        viewModel.didUpdatePermissionStatus = { [weak self] status in
            guard status == .authorized else { return }
            DispatchQueue.main.async {
//                let mapVC = MapTrackingViewController()
//                self?.present(mapVC, animated: true)
            }
        }

        customView.onAllowTap = { [weak self] in
            self?.viewModel.requestPermission()
        }
    }
}

