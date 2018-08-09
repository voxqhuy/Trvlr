//
//  CountriesViewController.swift
//  Trvlr
//
//  Created by Vo Huy on 8/3/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var continent: String!
    let countryBank = CountryBank()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = countryBank
        tableView.delegate = self
        searchBar.delegate = self
        tableView.tableHeaderView = UIView()
        navigationItem.titleView = searchBar
        
        loadCountries()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Table View
extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - Search bar
extension CountriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            countryBank.currentCountries = countryBank.allCountries
            tableView.reloadData()
            return
        }
        
        countryBank.filterCountries(withText: searchText)
        tableView.reloadData()
    }
}

// MARK: - Additional Helpers
extension CountriesViewController {
    func loadCountries() {
        // check archived files in Caches directory
        if !countryBank.allCountries.isEmpty {
            
        } else {
            TrvlrAPI.fetchCountries(byContinent: continent) { [unowned self] (countriesResult) in
                switch countriesResult {
                case let .success(countries):
                    
                    for country in countries {
                        let countryData = CountryData(name: country.1.name, capital: country.1.capital, currency: country.1.currency)
                        
                        self.countryBank.allCountries.append(countryData)
                    }
                    // archive countries into Caches directory
                    self.countryBank.saveCountries()
                    
                case let .failure(error):
                    self.countryBank.allCountries.removeAll()
                    
                    if error == .countryJsonError {
                        print("Error loading country Json")
                    } else if error == .countryDecodeError {
                        print("Error decoding country data")
                    } else {
                        print("Something is wrong with fetching countries")
                    }
                }
                
                self.countryBank.currentCountries = self.countryBank.allCountries
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }

//        do {
//            let data = try PropertyListEncoder().encode(self.allCountries)
//            let success = NSKeyedArchiver.archiveRootObject(data, toFile: )
//        }
    }
    
}
