//
//  MapViewController.swift
//  Trvlr
//
//  Created by Vo Huy on 8/3/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    let vinhAnnotation = Annotation(title: "Vinh city", coordinate: CLLocationCoordinate2D(latitude: 18.6796, longitude: 2015.6813))
    let phuketAnnotation = Annotation(title: "Phuket Island", coordinate: CLLocationCoordinate2D(latitude: 7.9519, longitude: 98.3381))
    let sauAnnotation = Annotation(title: "Collegedale city", coordinate: CLLocationCoordinate2D(latitude: 35.0531, longitude: -85.0502))
    override func loadView() {
        mapView = MKMapView()
        mapView.delegate = self
        let annotations = [vinhAnnotation, phuketAnnotation, sauAnnotation]
        mapView.addAnnotations(annotations)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MapViewController: MKMapViewDelegate {
    
}
