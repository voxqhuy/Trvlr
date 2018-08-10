//
//  Annotation.swift
//  Trvlr
//
//  Created by Vo Huy on 8/10/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import MapKit

class Annotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}
