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
    
    var countryBank = CountryBank()
    var continent: String! {
        didSet {
            countryBank = CountryBank(continent: continent)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = countryBank
        tableView.delegate = self
        searchBar.delegate = self
        tableView.tableHeaderView = UIView()
        navigationItem.titleView = searchBar
        
        let addCountriesItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showMoreCountries))
        navigationItem.rightBarButtonItem = addCountriesItem
        
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
            countryBank.currentCountries = countryBank.enabledCountries
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
        if countryBank.enabledCountries.isEmpty {
            TrvlrAPI.fetchCountries(byContinent: continent) { [unowned self] (countriesResult) in
                switch countriesResult {
                case let .success(countries):
                    
                    for country in countries {
                        let enabled = country.1.enabled
                        let countryData = CountryData(enabled: enabled, name: country.1.name, capital: country.1.capital, currency: country.1.currency)
                        if enabled {
                            self.countryBank.enabledCountries.append(countryData)
                        } else {
                            self.countryBank.disabledCountries.append(countryData)
                        }
                    }
                    // archive countries into Caches directory
                    self.countryBank.saveCountries()
                    
                case let .failure(error):
                    self.countryBank.enabledCountries.removeAll()
                    
                    if error == .countryJsonError {
                        print("Error loading country Json")
                    } else if error == .countryDecodeError {
                        print("Error decoding country data")
                    } else {
                        print("Something is wrong with fetching countries")
                    }
                }
                
                self.countryBank.currentCountries = self.countryBank.enabledCountries
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func showMoreCountries() {
        let navVC = UINavigationController()
        let moreCountriesVC = MoreCountriesTableViewController()
        moreCountriesVC.disabledCountries = countryBank.disabledCountries
        // set moreCountriesVC as the navVC's root view controller
        navVC.viewControllers = [moreCountriesVC]
        
        present(navVC, animated: true) { [unowned self] in
            self.tableView.reloadData()
        }
    }
}
