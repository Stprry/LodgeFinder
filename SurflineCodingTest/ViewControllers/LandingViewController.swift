//
//  ViewController.swift
//  SurflineCodingTest
//
//  Created by Sam Perry on 12/10/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class LandingViewController: UIViewController,MKMapViewDelegate{
  
    @IBOutlet weak var latFeild: UITextField!
    @IBOutlet weak var longFeild: UITextField!
    @IBOutlet weak var CurrentLocationButton: UIButton!
    @IBOutlet weak var ClearButton: UIButton!
    @IBOutlet weak var MapView: MKMapView!
  
    let reigonKM: Double = 1000
    let locationManager = CLLocationManager()
    var delegate:DataDelegate?
    var lat: String = ""
    var long: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        MapView.delegate = self
        checkLocationAuth()
        MapView.showsUserLocation = true // show location on map.
    }
    
    //MARK: -- Button Actions
    @IBAction func SearchBtnPress(_ sender: Any) {
        if latFeild.text == "" || longFeild.text == ""{
            // do alert saying must contain location ideally we use regex
        }else{
            lat = latFeild.text!
            long = longFeild.text!
        }
        delegate?.passLatLong(lat:lat,long:long) // pass value off text feilds
    }
    
    @IBAction func CurrentLocationBtn(_ sender: Any) {
        let center = getCenterLocation(for: MapView)
        lat = String(format:"%f", center.coordinate.latitude)
        long = String(format: "%f", center.coordinate.longitude)
        latFeild.text = lat
        longFeild.text = long
    }
    
    @IBAction func ClearBtnPress(_ sender: Any) {
        longFeild.text = ""
        latFeild.text = ""
    }
    
    //MARK: -- Location Set up and authorisation
    func locationManagerSetUp(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func checkLocationServices(){
        if  CLLocationManager.locationServicesEnabled(){
            locationManagerSetUp()
        }else{
           //show alert
        }
    }
    
    func checkLocationAuth(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse: // the main usage will be when in use so the bulk of code will be here.
            MapView.showsUserLocation = true // show location on map.
            centerViewOnUser() // zoom in to 1km of the user.
            locationManager.startUpdatingLocation() // start updating location incase the user moves.
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization() // request permissions
            break
        case .restricted:
           // display alert instructing them we need permissions
            break
        case .denied:
           // display alert instructing them we need permissions
            break
        case .authorizedAlways:// We arn't doing anythign with this beacuse we arn't requesting it
            break
        @unknown default:
            print("unknown auth status")
        }
    }
    func centerViewOnUser(){
        if let location = locationManager.location?.coordinate {
            let fetchReigon = MKCoordinateRegion.init(center: location, latitudinalMeters: reigonKM,longitudinalMeters: reigonKM)
            MapView.setRegion(fetchReigon, animated: true)
        }
    }
    
    func getCenterLocation(for MapView:MKMapView) -> CLLocation {
        let lat = MapView.centerCoordinate.latitude
        let long = MapView.centerCoordinate.longitude
        return CLLocation(latitude: lat, longitude: long)
    }
    
}
//MARK: -- Location Manager Delegates
extension LandingViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //update locations
        guard let location = locations.last else {return} // if last locations is nil, do nothing
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)// get users location from the location co-ordinates
        let reigon = MKCoordinateRegion(center: center, latitudinalMeters: reigonKM, longitudinalMeters: reigonKM)//create reigon 1km wide, with the user at center
        MapView.setRegion(reigon, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // check user change auth
        checkLocationAuth()
    }
}


