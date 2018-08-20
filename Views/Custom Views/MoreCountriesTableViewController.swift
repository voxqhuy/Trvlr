//
//  MoreCountriesTableViewController.swift
//  Trvlr
//
//  Created by Vo Huy on 8/14/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

protocol EditingCountriesDelegation {
    func updateCountries(enabledCountries: [CountryData], disabledCountries: [CountryData])
}

class MoreCountriesTableViewController: UITableViewController {

    let cellID = "cellID"
    var delegate:EditingCountriesDelegation!
    var disabledCountries = [CountryData]()
    var enabledCountries = [CountryData]()
    var selectedIndexes = [Int]()
    var selectedCountries = [CountryData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        for country in disabledCountries {
            country.enabled = false
        }
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton
        title = "Add more"
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
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        updateCountries()
        self.delegate.updateCountries(enabledCountries: enabledCountries, disabledCountries: disabledCountries)
        cancel()
    }
    
    @objc func cancel() {
        self.performSegue(withIdentifier: "backToCountries", sender: nil)
    }
}

extension MoreCountriesTableViewController {
    
    func updateCountries() {
        for (index, country) in disabledCountries.enumerated() {
            if country.enabled {
                selectedIndexes.append(index)
                selectedCountries.append(country)
            }
        }
        
        // exclude enabled countries from disabled countries array
        disabledCountries = disabledCountries
            .enumerated()
            .filter { !selectedIndexes.contains($0.offset) }
            .map { $0.element }
        
        // and add them to the enabled countries
        enabledCountries
            .append(contentsOf: selectedCountries)
        enabledCountries = enabledCountries.sorted(by: { $0.name < $1.name })
    }
}
