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
    
    var one: Int = 1
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isPitchEnabled = true
        mapView.isRotateEnabled = true
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
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
}

//MARK: - CLLocationManagerDelegate
extension MapView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        if let location = locations.last {
            //manager.stopUpdatingLocation()
            render(location)
        }
    }
    
    private func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
        let span = MKCoordinateSpan(latitudeDelta: 0.01,
                                    longitudeDelta: 0.01)
        if one == 1 {
            let region = MKCoordinateRegion(center: coordinate,
                                            span: span)
            mapView.setRegion(region,
                              animated: true)
            one -= 1
        }
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
}




