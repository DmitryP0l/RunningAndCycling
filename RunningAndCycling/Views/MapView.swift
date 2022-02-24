//
//  MapView.swift
//  RunningAndCycling
//
//  Created by lion on 23.02.22.
//

import UIKit
import MapKit
import CoreLocation

final class MapView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        return mapView
    }()
    
    let coordinate = CLLocationCoordinate2D()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(mapView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
