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
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    static let identifier = "CountryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        update(with: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        update(with: nil)
    }

    func update(with image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView?.image = imageToDisplay
        } else {
            spinner.startAnimating()
            imageView?.image = nil
        }
    }
}
