//
//  CitiesViewController.swift
//  Trvlr
//
//  Created by Vo Huy on 8/3/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var countryKey: String!
    var cities = [CityData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        loadCities()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "cityToExpense":
            let expenseVC = segue.destination as? ExpensesViewController
            expenseVC?.city = cities.first!
        default:
            fatalError("Unexpected segue identifier; \(String(describing: segue.identifier))")
        }
    }
}

// MARK: - UITableViewDataSource
extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") else { return UITableViewCell() }
        cell.textLabel?.text = cities[indexPath.row].name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.detailTextLabel?.text = ""
        return cell
    }
}

// - Addtional Helpers
extension CitiesViewController {
    func loadCities() {
        // TODO: check archived files
        TrvlrAPI.fetchCities(byCountry: countryKey) { [unowned self]
            (citiesResult) in
            switch citiesResult {
            case let .success(cities):
                self.cities = cities
            // TODO: archive cities into Docs Directory
            case let .failure(error):
                if error == .cityJsonError {
                    print("Error loading city Json")
                } else if error == .cityDecodeError {
                    print("Error decoding city data")
                } else {
                    print("Something is wrong with fetching cities")
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
