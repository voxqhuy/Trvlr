//
//  PlacesViewController.swift
//  Trvlr
//
//  Created by Vo Huy on 8/3/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

class ContinentsViewController: UITableViewController {

    fileprivate var continents = [String]()
    
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
        cell.textLabel?.text = continents[indexPath.row]
        
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
                self.continents.append(continent.af)
                self.continents.append(continent.an)
                self.continents.append(continent.continentAS)
                self.continents.append(continent.eu)
                self.continents.append(continent.na)
                self.continents.append(continent.oc)
                self.continents.append(continent.sa)
                print(self.continents)
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
            }
        }
    }
}
