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
    private let archiveKey = "countries.archive"
    private var allCountries = [CountryData]()
    private var currentCountries = [CountryData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
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
extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - Search bar
extension CountriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentCountries = allCountries
            tableView.reloadData()
            return
        }
        
        currentCountries = allCountries.filter { country -> Bool in
            return country.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}

// MARK: - Additional Helpers
extension CountriesViewController {
    func loadCountries() {
        TrvlrAPI.fetchCountries(byContinent: continent) { [unowned self] (countriesResult) in
            switch countriesResult {
            case let .success(countries):
                // TODO: append countries into countries and update labels texts accordingly
                for country in countries {
                    let countryData = CountryData(name: country.1.name, capital: country.1.capital, currency: country.1.currency)
                    
//                    let encoder = JSONEncoder()
//                    let jsonData = try encoder.encode(countryData)
                    self.allCountries.append(countryData)
                }
            case let .failure(error):
                self.allCountries.removeAll()
                if error == .countryJsonError {
                    print("Error loading country Json")
                } else if error == .countryDecodeError {
                    print("Error decoding country data")
                } else {
                    print("Something is wrong with fetching countries")
                }
            }
            self.currentCountries = self.allCountries
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
//        do {
//            let data = try PropertyListEncoder().encode(self.allCountries)
//            let success = NSKeyedArchiver.archiveRootObject(data, toFile: )
//        }
    }
    
    func saveCountries() -> Bool {
        let key = cachingURL(forKey: archiveKey)
        return NSKeyedArchiver.archiveRootObject(allCountries, toFile: key.path)
    }
}
