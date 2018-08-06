//
//  Country.swift
//  Trvlr
//
//  Created by Vo Huy on 8/6/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import Foundation

typealias Country = [String: CountryValue]

struct CountryValue: Codable {
    let name, native, phone: String
    let continent: Continent.CodingKeys
    let capital, currency: String
    let languages: [String]
}
