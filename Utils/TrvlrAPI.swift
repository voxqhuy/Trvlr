//
//  TrvlrAPI.swift
//  Trvlr
//
//  Created by Vo Huy on 8/4/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import Foundation

enum ContinentsResult {
    case success(Continent)
    case failure(ContinentError)
}

enum CountriesResult {
    case success(Country)
    case failure(CountryError)
}
struct TrvlrAPI {
    
    private static let continentUrl = URL(string: "https://api.myjson.com/bins/lylg0")
    private static let countryUrl = URL(string: "https://api.myjson.com/bins/g2ek0")
    
    static func fetchContinents(completion: @escaping (ContinentsResult) -> Void) {
        guard let downloadURL = continentUrl else { return }
        // its a continuous process -> resume to finish and return the url
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                completion(.failure(.continentJsonError))
                return
            }
            print("downloaded continents")
            do {
                let decoder = JSONDecoder()
                let continent = try decoder.decode(Continent.self, from: data)
                completion(.success(continent))
            } catch {
                completion(.failure(.continentDecodeError))
            }
        }.resume()
    }
    
    static func fetchCountries(completion: @escaping (CountriesResult) -> Void) {
        guard let downloadURL = countryUrl else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                completion(.failure(.countryJsonError))
                return
            }
            print("downloaded countries")
            do {
                let decoder = JSONDecoder()
                let country = try decoder.decode(Country.self, from: data)
                completion(.success(country))
            } catch {
                completion(.failure(.countryDecodeError))
            }
        }.resume()
    }
}
