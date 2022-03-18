////
////  MapViewController.swift
////  RunningAndCycling
////
////  Created by lion on 17.03.22.
////
//


// тут пока просто карта, основа. на нее будут накладываться наработки


//import UIKit
//import MapKit
//import SnapKit
//
//class MapViewController: UIViewController {
//
//    let locationManager = CLLocationManager()
//
//
//
//    private let containerView: UIView = {
//        let view = UIView()
//        return view
//    }()
//
//    private let mapView: MKMapView = {
//        let mapView = MKMapView()
//        mapView.isZoomEnabled = true
//        mapView.isScrollEnabled = true
//        return mapView
//    }()
//
//    private let closeButton: UIButton = {
//        let button = UIButton()
//        button.tintColor = .white
//        let image = UIImage(systemName: "xmark.circle.fill")
//        button.setBackgroundImage(image, for: .normal)
//        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        chekLocationEnabled()
//    }
//
//    private func setupView() {
//        view.addSubview(containerView)
//        containerView.addSubview(mapView)
//        mapView.addSubview(closeButton)
//        containerView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        mapView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        closeButton.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.bottom.equalToSuperview().inset(40.0)
//            make.height.width.equalTo(40.0)
//        }
//    }
//
//    @objc func closeButtonAction() {
//        dismiss(animated: true, completion: nil)
//    }
//
//    private func setupManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//
//    private func chekLocationEnabled() {
//        if CLLocationManager.locationServicesEnabled() {
//            setupManager()
//        } else {
//            let alert = UIAlertController(title: "location disabled", message: "turn on?", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "settings", style: .default, handler: { alert in
//                if let url = URL(string: "App-Prefs:root=LOCATION_SERVICES") {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                }
//            }))
//            alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
//            present(alert, animated: true, completion: nil)
//        }
//    }
//
//
//}
//
////MARK: - CLLocationManagerDelegate
//extension MapViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last?.coordinate {
//            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//            let region = MKCoordinateRegion(center: location, span: span)
//            mapView.setRegion(region, animated: true)
//
//        }
//    }
//
//}
//
////extension MapViewController: MKMapViewDelegate {
////    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
////        let renderer = MKPolylineRenderer(overlay: overlay)
////            renderer.strokeColor = UIColor.red
////            renderer.lineWidth = 4.0
////            return renderer
////    }
////}
//



// построено меду двумя точками
import UIKit
import MapKit

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}

class MapViewController: UIViewController, MKMapViewDelegate {

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
    
        private let closeButton: UIButton = {
            let button = UIButton()
            button.tintColor = .white
            let image = UIImage(systemName: "xmark.circle.fill")
            button.setBackgroundImage(image, for: .normal)
            button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
            return button
        }()
    
    private func setupView() {
            view.addSubview(containerView)
            containerView.addSubview(mapView)
            mapView.addSubview(closeButton)
            containerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            mapView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            closeButton.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().inset(40.0)
                make.height.width.equalTo(40.0)
            }
        }
    
        @objc func closeButtonAction() {
            dismiss(animated: true, completion: nil)
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view, typically from a nib.
        
        let sourceLocation = CLLocationCoordinate2D(latitude:39.173209 , longitude: -94.593933)
        let destinationLocation = CLLocationCoordinate2D(latitude:38.643172 , longitude: -90.177429)
        
        let sourcePin = customPin(pinTitle: "Start", pinSubTitle: "", location: sourceLocation)
        let destinationPin = customPin(pinTitle: "You", pinSubTitle: "", location: destinationLocation)
        self.mapView.addAnnotation(sourcePin)
        self.mapView.addAnnotation(destinationPin)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResonse = response else {
                if let error = error {
                    print("we have error getting directions==\(error.localizedDescription)")
                }
                return
            }
            
            let route = directionResonse.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        
        //set delegate for mapview
        self.mapView.delegate = self


    }
    
    //MARK:- MapKit delegates
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
