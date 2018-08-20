//
//  ExpenseView.swift
//  Trvlr
//
//  Created by Vo Huy on 8/16/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

class ExpenseView: NibView {

    weak var expenseDelegate: ExpenseDelegate!
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var cityExpenseLabel: UILabel!
    @IBOutlet var daysTextField: UITextField!
    @IBOutlet var peopleTextField: UITextField!
    @IBOutlet var totalLabel: UILabel!
    
    @IBAction func removeADay(_ sender: UIButton) {
        expenseDelegate.removeADay()
        expenseDelegate.updateTotal()
    }
    
    @IBAction func addADay(_ sender: UIButton) {
        expenseDelegate.addADay()
        expenseDelegate.updateTotal()
    }
    
    @IBAction func removeAPerson(_ sender: UIButton) {
        expenseDelegate.removeAPerson()
        expenseDelegate.updateTotal()
    }
    
    @IBAction func addAPerson(_ sender: UIButton) {
        expenseDelegate.addAPerson()
        expenseDelegate.updateTotal()
    }
}
