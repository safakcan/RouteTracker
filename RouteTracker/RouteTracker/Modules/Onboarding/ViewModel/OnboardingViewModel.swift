//
//  OnboardingViewModel.swift
//  RouteTracker
//
//  Created by Can Bas on 24.05.2025.
//

import Foundation

protocol OnboardingViewModelProtocol {
    var welcomeText: String { get }
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    var welcomeText: String = "Welcome to RouteTracker"
}
