//
//  ContinentDataSource.swift
//  Trvlr
//
//  Created by Vo Huy on 8/4/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

class ContinentStore: NSObject, UITableViewDataSource {
    let continents = ["Europe", "Asia", "North America", "South America", "Africa", "Oceania", "Antarctica"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return continents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ContinentCell")
        cell.detailTextLabel?.text = continents[indexPath.row]
        
        return cell
    }
}
