//
//  CountryCell.swift
//  Trvlr
//
//  Created by Vo Huy on 8/6/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet var countryNameLabel: UILabel!
    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
