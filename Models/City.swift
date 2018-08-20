//
//  City.swift
//  Trvlr
//
//  Created by Vo Huy on 8/16/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

typealias City = [CityData]

struct CityData: Codable {
    let country, name: String
    let coordinates: [Double]
    let expense: Double
}
