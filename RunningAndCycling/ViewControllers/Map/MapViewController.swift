//
//  MapViewController.swift
//  RunningAndCycling
//
//  Created by lion on 17.03.22.
//
//



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
    
    var coorList: [CLLocationCoordinate2D] = [] {
        didSet {
            drawPolyLine()
        }
    }

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
        drawPolyLine()
        self.mapView.delegate = self
    }
    
    func drawPolyLine() {
        var polyline = MKPolyline(coordinates: &coorList, count: coorList.count)
                mapView.addOverlay(polyline)
    }

    //MARK:- MapKit delegates
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.blue.withAlphaComponent(0.9)
            renderer.lineWidth = 7
            return renderer
        }
        return MKOverlayRenderer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
