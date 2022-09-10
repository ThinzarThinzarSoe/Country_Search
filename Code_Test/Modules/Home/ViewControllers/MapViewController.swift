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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationTitle(title: "Location")
        mapView.isHidden = true
        setupData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView.isHidden = true
    }
    
    func setupData() {
        if InternetConnectionManager.shared.isConnectedToNetwork() {
            mapView.isHidden = false
            setupMapView()
        } else {
            mapView.isHidden = true
            self.isShowNoDataAndInternet(isShow: true)
        }
    }
    
    override func setupUI() {
        super.setupUI()
        isShowNavigationBar(true)
        addBackButton()
        self.view.backgroundColor = .white
    }
    
    override func reloadScreen() {
        super.reloadScreen()
        setupData()
    }
    
    func setupMapView() {
        guard let countryData = countryData else {
            return
        }

        let cityCoordinate = CLLocationCoordinate2D(latitude: countryData.coord?.lat ?? 0,
                                                    longitude: countryData.coord?.lon ?? 0)
        mapView.setCenter(cityCoordinate, animated: true)

        annotation = MKPointAnnotation()
        annotation?.title = countryData.name
        annotation?.coordinate = cityCoordinate
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        if let annotation = annotation {
            mapView.addAnnotation(annotation)
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
}
