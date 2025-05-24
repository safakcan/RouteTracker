//
//  OnboardingView.swift
//  RouteTracker
//
//  Created by Can Bas on 24.05.2025.
//

import UIKit

import UIKit

final class OnboardingView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var allowLocationButton: UIButton!
    @IBOutlet weak var view: UIView!

    var onAllowTap: (() -> Void)?

    @IBAction func allowTapped(_ sender: UIButton) {
        onAllowTap?()
    }

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
        guard let loadedView = nib.instantiate(withOwner: self).first as? UIView else { return }
        loadedView.frame = self.bounds
        loadedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(loadedView)
        configureUI()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        backgroundColor = .white

        allowLocationButton.setTitle("Allow Location Access", for: .normal)

    }

}

