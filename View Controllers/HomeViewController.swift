//
//  HomeViewController.swift
//  Trvlr
//
//  Created by Vo Huy on 8/4/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseACountry(_ sender: UIButton) {
        let continentsScene = ContinentsViewController.instantiate(fromAppStoryboard: .Place)
        if let navigator = navigationController {
            navigator.pushViewController(continentsScene, animated: true)
        }
    }
    
    
}
