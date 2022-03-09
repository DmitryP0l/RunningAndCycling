//
//  MapView.swift
//  RunningAndCycling
//
//  Created by lion on 23.02.22.
//

import UIKit
import MapKit
import CoreLocation

final class MapView: UIView{
    
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
    let manager = CLLocationManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupManager()
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
    
    private func setupManager() {
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    
}


extension MapView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region,
                          animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
}
