//
//  JsonHelpers.swift
//  Trvlr
//
//  Created by Vo Huy on 8/4/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import Foundation

class JsonHelper {
    
    final private let continentUrl = URL(string: "https://api.myjson.com/bins/lylg0")
    
    func getContinentJson() {
        downloadJson(url: continentUrl)
    }
    
}

extension JsonHelper {
    private func downloadJson(url: URL?) {
        guard let downloadURL = url else { return }
        // its a continuous process -> resume to finish and return the url
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            print("download")
        }.resumse()
    }
}
