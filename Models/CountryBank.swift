//
//  CountryBank.swift
//  Trvlr
//
//  Created by Vo Huy on 8/9/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

class CountryBank: NSObject {
    let enabledArchiveKey = "enabledCountries.archive"
    let disabledArchiveKey = "disabledCountries.archive"
    var enabledDocumentKey: URL!
    var disabledDocumentKey: URL!
    var continent: String!
    
    var enabledCountries = [CountryData]()
    var disabledCountries = [CountryData]()
    var currentCountries = [CountryData]()
    
    override init() {
        super.init()
    }
    
    init(continent: String) {
        self.continent = continent
        self.enabledDocumentKey = documentURL(forKey: "\(continent).\(enabledArchiveKey)")
        self.disabledDocumentKey = documentURL(forKey: "\(continent).\(disabledArchiveKey)")
        
        guard let enabledData = NSKeyedUnarchiver.unarchiveObject(withFile: enabledDocumentKey.path) as? Data else { return }
        guard let disabledData = NSKeyedUnarchiver.unarchiveObject(withFile: disabledDocumentKey.path) as? Data else { return }
        do {
            let archivedEnabledCountries = try PropertyListDecoder().decode([CountryData].self, from: enabledData)
            enabledCountries = archivedEnabledCountries
            currentCountries = enabledCountries
        } catch {
            print("Decoding enabled countries failed")
        }
        
        do {
            let archivedDisabledCountries = try PropertyListDecoder().decode([CountryData].self, from: disabledData)
            disabledCountries = archivedDisabledCountries
        } catch {
            print("Decoding disabled countries failed")
        }
    }
    
//    override init() {
//        super.init()
//
//    }
    
    func filterCountries(withText text: String) {
        currentCountries = enabledCountries.filter { country -> Bool in
            return country.name.lowercased().contains(text.lowercased())
        }
    }
    
    func saveCountries() {
        do {
            // archive enabled countries
            let enabledData = try PropertyListEncoder().encode(enabledCountries)
            let success = NSKeyedArchiver.archiveRootObject(enabledData, toFile: enabledDocumentKey.path)
            
            print(success ? "Successfully saved enabled countries" : "aving enabled countries failed")
        } catch {
            print("Saving enabled countries failed")
        }
        
        do {
            // archive disabled countries
            let disabledData = try PropertyListEncoder().encode(disabledCountries)
            let success = NSKeyedArchiver.archiveRootObject(disabledData, toFile: disabledDocumentKey.path)
            
            print(success ? "Successfully saved disabled countries" : "Saving disabled countries failed")
        } catch {
            print("Saving disabled countries failed")
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
