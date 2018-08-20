//
//  ExpenseDelegate.swift
//  Trvlr
//
//  Created by Vo Huy on 8/17/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import Foundation

protocol ExpenseDelegate: class {
    
    func removeADay()
    
    func addADay()
    
    func removeAPerson()
    
    func addAPerson()
    
    func updateTotal()
}
