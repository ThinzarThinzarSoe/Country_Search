//
//  MapViewController.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/9/22.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController : BaseViewController {

    @IBOutlet weak var mapView: MKMapView!

    var countryData : CountryResponse?
    var annotation: MKPointAnnotation?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationTitle(title: "Location")
        setupMapView()
    }
    
    override func setupUI() {
        super.setupUI()
        isShowNavigationBar(true)
        addBackButton()
    }
    
    override func bindData() {
        super.bindData()
    }
    
    func setupMapView() {
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true

        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
        
        annotation = MKPointAnnotation()
        annotation?.title = countryData?.name
        annotation?.coordinate.latitude = countryData?.coord?.lat ?? 0.0
        annotation?.coordinate.longitude = countryData?.coord?.lon ?? 0.0
    }
}

extension MapViewController : CLLocationManagerDelegate,MKMapViewDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let span = MKCoordinateSpan(latitudeDelta: countryData?.coord?.lat ?? 0.0, longitudeDelta: countryData?.coord?.lon ?? 0.0)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        if let annotation = annotation {
            mapView.addAnnotation(annotation)
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
}
