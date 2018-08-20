//
//  Expense.swift
//  Trvlr
//
//  Created by Vo Huy on 8/17/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import Foundation

struct Expense {
    var daysCount: Int = 3
    var peopleCount: Int = 2
    var cityExpense: Double
    
    init(cityExpense: Double) {
        self.cityExpense = cityExpense
    }
    
    var total: Double {
        return Double(daysCount * peopleCount) * cityExpense
    }
}
