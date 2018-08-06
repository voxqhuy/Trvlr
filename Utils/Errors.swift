//
//  Errors.swift
//  Trvlr
//
//  Created by Vo Huy on 8/4/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import Foundation

enum ContinentError: Error {
    case continentJsonError
    case continentDecodeError
}

enum CountryError: Error {
    case countryJsonError
    case countryDecodeError
}
