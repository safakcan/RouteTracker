//
//  OnboardingView.swift
//  RouteTracker
//
//  Created by Can Bas on 24.05.2025.
//

import UIKit

final class OnboardingView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var view: UIView!

    // Load from XIB
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }

    private func loadFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "OnboardingView", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self).first as? UIView else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
