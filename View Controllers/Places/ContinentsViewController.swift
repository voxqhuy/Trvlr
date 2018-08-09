//
//  PlacesViewController.swift
//  Trvlr
//
//  Created by Vo Huy on 8/3/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

class ContinentsViewController: UITableViewController {

    fileprivate var continents = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        loadContinents()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier {
        case "showCountries":
            guard let selectedIndexPath = tableView.indexPathsForSelectedRows?.first else { return }
            let continentKey = Array(continents)[selectedIndexPath.row].key
            guard let countriesVC = segue.destination as? CountriesViewController else { return }
            countriesVC.continent = continentKey
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }

}

// MARK: - UITableViewDataSource
extension ContinentsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return continents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContinentCell", for: indexPath)
        cell.textLabel?.text = Array(continents)[indexPath.row].value
        
        return cell
    }
}

// MARK: - Additional Helpers
extension ContinentsViewController {
    func loadContinents() {
        TrvlrAPI.fetchContinents {
            [unowned self] (continentsResult) in
            switch continentsResult {
            case let .success(continent):
                self.continents["AF"] = continent.af
                self.continents["AN"] = continent.an
                self.continents["AS"] = continent.continentAS
                self.continents["EU"] = continent.eu
                self.continents["NA"] = continent.na
                self.continents["OC"] = continent.oc
                self.continents["SA"] = continent.sa
            case let .failure(error):
                self.continents.removeAll()
                if error == .continentJsonError {
                    print("Error loading continent Json")
                } else if error == .continentDecodeError {
                    print("Error decoding continent data")
                } else {
                    print("Something is wrong with fetching continents")
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(self.tableView.numberOfRows(inSection: 0))
            }
            
        }
    }
}
