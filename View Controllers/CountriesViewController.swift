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
    
    fileprivate var countries = [Country]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        loadCountries()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
        // TODO: imageview
        return cell
    }
}

extension CountriesViewController {
    func loadCountries() {
        TrvlrAPI.fetchCountries { [unowned self] (countriesResult) in
            switch countriesResult {
            case let .success(country):
                print("success countries")
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
