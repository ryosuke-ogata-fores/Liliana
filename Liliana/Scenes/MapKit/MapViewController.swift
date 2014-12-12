//
//  MapViewController.swift
//  Liliana
//
//  Created by r-ogata on 2014/12/09.
//  Copyright (c) 2014 rogata. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var bottomMenuView: UIView!
    
    var locationManager:CLLocationManager!
    var userLocation:CLLocation!
    var destinationLocation:CLLocation!
    var destinationAnnotation:MKAnnotation!
    var destinationAnnotationView:MKAnnotationView!
    var isVisiblePolyLine = false
    var polyline:MKPolyline!
    
    @IBOutlet var mapButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        for btn in mapButtons {
            btn.layer.cornerRadius = CGRectGetHeight(btn.frame) / 4
            btn.layer.masksToBounds = true
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // GPS開始
        if self.locationManager == nil  {
            self.locationManager = CLLocationManager()
        }
        self.locationManager.distanceFilter = 1
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        // マップ初期調整
        self.mapView.mapType = MKMapType.Standard
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        // GPS開始
        if locationManager == nil  {
            locationManager.stopUpdatingLocation()
        }
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }

    @IBAction func moveToUserLocation(sender: AnyObject) {
        if userLocation != nil {
        self.mapView.setCenterCoordinate(userLocation.coordinate, animated: true)
    }

    }
    @IBAction func togglePolyline(sender: AnyObject) {
        self.isVisiblePolyLine = !self.isVisiblePolyLine
        self.redrawPolyline()
    }
    @IBAction func moveToDestination(sender: AnyObject) {
        if (destinationLocation == nil) {
            return;
        }
        self.mapView.setCenterCoordinate(destinationLocation.coordinate, animated: true)
    }
    
    /** Private Methods */
    
    private func redrawPolyline() {
        // ラインを消す
        self.mapView.removeOverlay(polyline)
        polyline = nil

        if self.isVisiblePolyLine {
            // ラインを引く
            if userLocation == nil || destinationLocation == nil {
                return
            }
            var locationPoints = [
                userLocation.coordinate,
                destinationLocation.coordinate
            ]
            self.polyline = MKPolyline(coordinates: &locationPoints, count: 2)
            self.mapView.addOverlay(self.polyline)
        }
    }
    
    /**
    *  CLLocationManagerDelegate
    */
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        self.userLocation = locations[0] as CLLocation
    }
    
    /**
    *  MKMapViewDelegate
    */
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }
        return nil
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        // 目的地ピンを初期化
        if (destinationAnnotationView == nil) {
            destinationAnnotationView = self.mapView.dequeueReusableAnnotationViewWithIdentifier(DestinationAnnotationView.identifier())
            if (destinationAnnotationView == nil) {
                destinationAnnotationView = DestinationAnnotationView(
                    annotation: annotation,
                    reuseIdentifier: DestinationAnnotationView.identifier())
            }
        }
        // 目的地がセットされてたら描画
        if (destinationLocation != nil) {
            return destinationAnnotationView
        }
        return nil
    }
    /**
    UITapGestureRecognizer
    
    :param: sender UITapGestureRecognizer
    */
    @IBAction func didLongPressedMapView(sender: UILongPressGestureRecognizer) {
        if (sender.state != UIGestureRecognizerState.Began) {
            return
        }
        // タップした位置を緯度経度に変換してサークルを表示
        var tapPoint = sender.locationInView(self.view)
        var center = self.mapView.convertPoint(tapPoint, toCoordinateFromView: self.mapView)
        destinationLocation = CLLocation(
            latitude:center.latitude as CLLocationDegrees,
            longitude:center.longitude as CLLocationDegrees)
        self.isVisiblePolyLine = true
        self.redrawPolyline()
        // アノテーションを削除・追加
        if (destinationAnnotation != nil) {
            self.mapView.removeAnnotation(destinationAnnotation)
        }
        destinationAnnotation = MKPlacemark(
            coordinate: destinationLocation.coordinate,
            addressDictionary: nil)
        self.mapView.addAnnotation(destinationAnnotation)
    }

}
