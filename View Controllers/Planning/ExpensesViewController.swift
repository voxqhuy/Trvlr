//
//  ExpensesViewController.swift
//  Trvlr
//
//  Created by Vo Huy on 8/3/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

class ExpensesViewController: UIViewController {

    @IBOutlet var expenseView: ExpenseView!
    var city: CityData!
    var expense: Expense!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        expenseView.expenseDelegate = self
        
        title = city.name
        expenseView.cityLabel.text = "\(city.name) expense rate"
        expenseView.cityExpenseLabel.text = "$\(city.expense)"
        expense = Expense(cityExpense: city.expense)
        
        updateTotal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ExpensesViewController: ExpenseDelegate {
    func removeADay() {
        expense.daysCount -= 1
    }
    
    func addADay() {
        expense.daysCount += 1
    }
    
    func removeAPerson() {
        expense.peopleCount -= 1
    }
    
    func addAPerson() {
        expense.peopleCount += 1
    }
    
    func updateTotal() {
        expenseView.daysTextField.text = "\(expense.daysCount)"
        expenseView.peopleTextField.text = "\(expense.peopleCount)"
        expenseView.totalLabel.text = "\(expense.total)"
    }
}
