//
//  CountryBank.swift
//  Trvlr
//
//  Created by Vo Huy on 8/9/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

class CountryBank: NSObject {
    let archiveKey = "countries.archive"
    var cachingKey: URL {
        return cachingURL(forKey: archiveKey)
    }
    var allCountries = [CountryData]()
    var currentCountries = [CountryData]()
    
    override init() {
        super.init()
        
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: cachingKey.path) as? Data else { return }
        do {
            let archivedCountries = try PropertyListDecoder().decode([CountryData].self, from: data)
            allCountries = archivedCountries
            currentCountries = allCountries
        } catch {
            print("Decode archived countries failed")
        }
    }
    
    func filterCountries(withText text: String) {
        currentCountries = allCountries.filter { country -> Bool in
            return country.name.lowercased().contains(text.lowercased())
        }
    }
    
    func saveCountries() {
        do {
            let data = try PropertyListEncoder().encode(allCountries)
            let success = NSKeyedArchiver.archiveRootObject(data, toFile: cachingKey.path)
            print(success ? "Successful save" : "Save failed")
        } catch {
            print("Save failed")
        }
    }
}


extension CountryBank: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier) as? CountryCell else {
            return UITableViewCell()
        }
        
        let country = currentCountries[indexPath.row]
        cell.countryNameLabel?.text = country.name
        if country.capital != "" {
            cell.capitalLabel?.text = "Capital: \n\(country.capital)"
        }
        if country.currency != "" {
            cell.currencyLabel.text = "Currency: \n\(country.currency)"
        }
        
        return cell
    }
}
