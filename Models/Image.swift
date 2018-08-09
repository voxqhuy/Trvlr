//
//  Image.swift
//  Trvlr
//
//  Created by Vo Huy on 8/8/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import UIKit

struct Image {
    let cache = NSCache<NSString, UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        let url = documentURL(forKey: key)
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            let _ = try? data.write(to: url, options: [.atomic])
        }
    }
    
    func getImage(forKey key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        let url = documentURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    func removeImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = documentURL(forKey: key)
        removeItem(at: url)
    }
}
