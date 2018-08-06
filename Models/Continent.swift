//
//  Continent.swift
//  Trvlr
//
//  Created by Vo Huy on 8/4/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import Foundation

struct Continent: Codable {
    let af, an, continentAS, eu, na, oc, sa: String
    
    enum CodingKeys: String, CodingKey, Codable {
        case af = "AF"
        case an = "AN"
        case continentAS = "AS"
        case eu = "EU"
        case na = "NA"
        case oc = "OC"
        case sa = "SA"
    }
}
