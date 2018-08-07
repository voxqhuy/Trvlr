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
    fileprivate var countries = [CountryData]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        
        loadCountries()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as? CountryCell else {
            return UITableViewCell()
        }
        
        let country = countries[indexPath.row]
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

extension CountriesViewController {
    func loadCountries() {
        TrvlrAPI.fetchCountries(byContinent: continent) { [unowned self] (countriesResult) in
            switch countriesResult {
            case let .success(countries):
                // TODO: append countries into countries and update labels texts accordingly
                for country in countries {
                    let countryData = CountryData(name: country.1.name, capital: country.1.capital, currency: country.1.currency)
                    self.countries.append(countryData)
                }
            case let .failure(error):
                self.countries.removeAll()
                if error == .countryJsonError {
                    print("Error loading country Json")
                } else if error == .countryDecodeError {
                    print("Error decoding country data")
                } else {
                    print("Something is wrong with fetching countries")
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
