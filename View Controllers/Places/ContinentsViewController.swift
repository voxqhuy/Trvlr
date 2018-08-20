//
//  PlacesViewController.swift
//  Trvlr
//
//  Created by Vo Huy on 8/3/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

class ContinentsViewController: UITableViewController {

    fileprivate var continents = [String: ContinentData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15)
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
            let continentKey = Array(continents)[selectedIndexPath.section].key
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
        return continents.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContinentCell.identifier) as? ContinentCell else {
            return UITableViewCell()
        }
        let continentData = Array(continents)[indexPath.section].value
        cell.continentNameLabel.text = continentData.name
        cell.continentNameLabel.layer.zPosition = 1
        cell.bgView.image = continentData.image
        cell.bgView.alpha = 0.8
        cell.backgroundColor = cell.backgroundColor
        cell.backgroundColor = cell.contentView.backgroundColor
        
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
                self.continents["AF"] = ContinentData(name: continent.af, image: UIImage(named: "Africa")!)
                self.continents["AS"] = ContinentData(name: continent.continentAS, image: UIImage(named: "Asia")!)
                self.continents["EU"] = ContinentData(name: continent.eu, image: UIImage(named: "Europe")!)
                self.continents["NA"] = ContinentData(name: continent.na, image: UIImage(named: "North America")!)
                self.continents["SA"] = ContinentData(name: continent.sa, image: UIImage(named: "South America")!)
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
