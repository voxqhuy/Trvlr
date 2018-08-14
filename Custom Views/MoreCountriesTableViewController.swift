//
//  MoreCountriesTableViewController.swift
//  Trvlr
//
//  Created by Vo Huy on 8/14/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

class MoreCountriesTableViewController: UITableViewController {

    let cellID = "cellID"
    var disabledCountries = [CountryData]()
    var selectedIndexes = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAdding))
        navigationItem.rightBarButtonItem = doneButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return disabledCountries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = disabledCountries[indexPath.row].name
        if disabledCountries[indexPath.row].enabled {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        disabledCountries[indexPath.row].enabled = !disabledCountries[indexPath.row].enabled

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
}

extension MoreCountriesTableViewController {
    @objc func doneAdding() {
        updateCountries()
        
        dismiss(animated: true, completion: nil)
    }
    
    func updateCountries() {
        for (index, country) in disabledCountries.enumerated() {
            if country.enabled {
                selectedIndexes.append(index)
            }
        }
        
        // exclude enabled countries from disabled countries array
        disabledCountries = disabledCountries
            .enumerated()
            .filter { !selectedIndexes.contains($0.offset) }
            .map { $0.element }
        
        // and add them to the enabled countries
    }
}
