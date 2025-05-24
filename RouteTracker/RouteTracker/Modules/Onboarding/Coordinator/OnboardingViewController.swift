//
//  OnboardingViewController.swift
//  RouteTracker
//
//  Created by Can Bas on 24.05.2025.
//

import UIKit

final class OnboardingViewController: UIViewController {

    private let customView = OnboardingView()
    private let viewModel: OnboardingViewModelProtocol

    init(viewModel: OnboardingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.titleLabel.text = viewModel.welcomeText
    }
}
