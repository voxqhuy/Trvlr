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

    var mapView: MKMapView!
    let vinhAnnotation = Annotation(title: "Vinh city", coordinate: CLLocationCoordinate2D(latitude: 18.6796, longitude: 2015.6813))
    let phuketAnnotation = Annotation(title: "Phuket Island", coordinate: CLLocationCoordinate2D(latitude: 7.9519, longitude: 98.3381))
    let sauAnnotation = Annotation(title: "Collegedale city", coordinate: CLLocationCoordinate2D(latitude: 35.0531, longitude: -85.0502))
    
    override func loadView() {
        mapView = MKMapView()
        mapView.delegate = self
        let annotations = [vinhAnnotation, phuketAnnotation, sauAnnotation]
        mapView.addAnnotations(annotations)
        mapView.showsCompass = false
        mapView.showsScale = true
        
        view = mapView
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
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Annotation else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            view.canShowCallout = true
//            view.calloutOffset = CGPoint(x: 0, y: 20)
//            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
