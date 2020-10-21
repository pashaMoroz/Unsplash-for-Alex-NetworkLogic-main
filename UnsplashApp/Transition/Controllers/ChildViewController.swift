//
//  ChildViewController.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 16.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ChildViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {


    var window: UIWindow?
    var mapView: MKMapView?
    var locationManager: CLLocationManager?
    var usersCurrentLocation:CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.layer.cornerRadius = 24

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.white

        let leftMargin:CGFloat = 10
        let topMargin:CGFloat = 60
        let mapWidth:CGFloat = view.frame.size.width-20
        let mapHeight:CGFloat = 170

        mapView = MKMapView()
        mapView?.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)


        self.locationManager = CLLocationManager()
        if let locationManager = self.locationManager {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
        }

        self.locationManager = CLLocationManager()

        if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager?.requestAlwaysAuthorization()
        }

        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = 200
        locationManager?.delegate = self
        startUpdatingLocation()

        let firstCoorditate = 51.507222
        let secondCoordinate = -0.1275

        usersCurrentLocation = CLLocationCoordinate2DMake(firstCoorditate,secondCoordinate)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: usersCurrentLocation!, span: span)
        mapView?.setRegion(region, animated: true)
        mapView?.delegate = self
        mapView?.showsUserLocation = true


        let london = MKPointAnnotation()
        london.title = "London"
        london.coordinate = CLLocationCoordinate2D(latitude: firstCoorditate, longitude: secondCoordinate)
        mapView?.addAnnotation(london)

        addDismissButton()

    }

    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
    }

    private func addDismissButton() {

        // Создание Кнопки
        let closeButton = UIButton()
        closeButton.addTarget(self, action: #selector(dismissSelf), for:.touchUpInside)
        closeButton.setTitle("Close", for: .normal)
        closeButton.titleLabel?.font =  UIFont(name: "HelveticaNeue", size: 16)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)

        // Создание Линии
        let line = UIView()
        view.addSubview(line)
        line.backgroundColor = .gray
        line.translatesAutoresizingMaskIntoConstraints = false

        // Создание Титла
        let title = UILabel()
        title.text = "Info"
        title.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        view.addSubview(title)
        title.tintColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false

        //Map
        view.addSubview(mapView!)

        // Создание Линии2
        let line2 = UIView()
        view.addSubview(line2)
        line2.backgroundColor = .gray
        line2.translatesAutoresizingMaskIntoConstraints = false

        let imagePin = UIImageView()
        imagePin.image = UIImage(systemName: "mappin.and.ellipse")
        imagePin.translatesAutoresizingMaskIntoConstraints = false
        imagePin.tintColor = .systemGray
        view.addSubview(imagePin)

        let locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.tintColor = .systemGray
        locationLabel.text = "London"
        locationLabel.font = UIFont(name: "HelveticaNeue", size: 15.0)
        view.addSubview(locationLabel)


        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            line.widthAnchor.constraint(equalToConstant: view.bounds.width),
            line.heightAnchor.constraint(equalToConstant: 0.3),
            line.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 5)
        ])

        NSLayoutConstraint.activate([
            line2.widthAnchor.constraint(equalToConstant: view.bounds.width),
            line2.heightAnchor.constraint(equalToConstant: 0.3),
            line2.topAnchor.constraint(equalTo: imagePin.bottomAnchor, constant: 30)
        ])

        NSLayoutConstraint.activate([
            imagePin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imagePin.topAnchor.constraint(equalTo: mapView!.bottomAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: imagePin.trailingAnchor, constant: 5),
            locationLabel.centerYAnchor.constraint(equalTo: imagePin.centerYAnchor)
        ])

    }

    @objc func dismissSelf() {
        self.dismiss(animated: true)
    }
}
