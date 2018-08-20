//
//  ContinentCell.swift
//  Trvlr
//
//  Created by Vo Huy on 8/9/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

class ContinentCell: UITableViewCell {

    @IBOutlet var continentNameLabel: UILabel!
    @IBOutlet var bgView: UIImageView!
    static let identifier = "ContinentCell"
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame = newValue
            frame.origin.x += 8
            frame.size.width -= 16
            
            super.frame = frame
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        super .draw(rect)
        
        layer.cornerRadius = 4
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
