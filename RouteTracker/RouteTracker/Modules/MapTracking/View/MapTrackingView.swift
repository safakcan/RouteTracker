//
//  MapTrackingView.swift
//  RouteTracker
//
//  Created by Can Bas on 25.05.2025.
//

import Foundation
import UIKit
import MapKit

final class MapTrackingView: UIView {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var trackingInfoLabel: UILabel!
    @IBOutlet weak var centerUserButton: UIButton!
  
    var onCenterTap: (() -> Void)?
    var onStartTap: (() -> Void)?
    var onDeleteTap: (() -> Void)?

    @IBAction func centerUserTapped(_ sender: UIButton) {
        onCenterTap?()
    }

    @IBAction func startTapped(_ sender: UIButton) {
        onStartTap?()
    }

    @IBAction func deleteTapped(_ sender: UIButton) {
        onDeleteTap?()
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
        let nib = UINib(nibName: "MapTrackingView", bundle: bundle)
        guard let loadedView = nib.instantiate(withOwner: self).first as? UIView else { return }
        loadedView.frame = self.bounds
        loadedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(loadedView)
        setupUI()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    private func setupUI() {
        self.backgroundColor = .white
        mapView.showsUserLocation = true

        startButton.layer.cornerRadius = 12


        deleteButton.layer.cornerRadius = 12
        deleteButton.setTitle("", for: .normal)

        trackingInfoLabel.layer.cornerRadius = 10
        trackingInfoLabel.clipsToBounds = true
        trackingInfoLabel.numberOfLines = 2
        trackingInfoLabel.textAlignment = .center
        trackingInfoLabel.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        trackingInfoLabel.textColor = .black
        trackingInfoLabel.font = .systemFont(ofSize: 14, weight: .medium)
        trackingInfoLabel.text = "Tracking Off\n–"

        centerUserButton.layer.cornerRadius = 12
        centerUserButton.backgroundColor = .white
        centerUserButton.setTitle("", for: .normal)
        centerUserButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        centerUserButton.imageView?.contentMode = .scaleAspectFit
        centerUserButton.contentHorizontalAlignment = .fill
        centerUserButton.contentVerticalAlignment = .fill
        centerUserButton.tintColor = .systemBlue
        centerUserButton.titleEdgeInsets = .zero


    }
}
