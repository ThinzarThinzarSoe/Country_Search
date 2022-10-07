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

    var countryData : CountryVO?
    var annotation: MKPointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.isHidden = true
        setupData()
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
        if let city = countryData {
            self.title = city.name
            self.addPin(title: city.name ?? "" , coord: city.coord ?? CoordinateVO(lon: 0.0, lat: 0.0))
            self.focusMapView(coord: city.coord ?? CoordinateVO(lon: 0.0, lat: 0.0))
        }
    }
    
    private func addPin(title: String, coord: CoordinateVO) {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: coord.lat ?? 0.0, longitude: coord.lon ?? 0.0)
        annotation.coordinate = centerCoordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
    }

    private func focusMapView(coord: CoordinateVO) {
        let mapCenter = CLLocationCoordinate2DMake(coord.lat ?? 0.0, coord.lon ?? 0.0)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: mapCenter, span: span)
        mapView.region = region
    }
}
