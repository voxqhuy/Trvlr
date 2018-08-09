//
//  System.swift
//  Trvlr
//
//  Created by Vo Huy on 8/8/18.
//  Copyright © 2018 Vo Huy. All rights reserved.
//

import Foundation

func cachingURL(forKey key: String) -> URL {
    let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    return cacheDirectory.appendingPathComponent(key)
}

func documentURL(forKey key: String) -> URL {
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentDirectory.appendingPathComponent(key)
}

func isWritable(file url: URL) -> Bool {
    return FileManager.default.isWritableFile(atPath: url.path)
}

func isReadable(file url: URL) -> Bool {
    return FileManager.default.isReadableFile(atPath: url.path)
}

func exists(file url: URL) -> Bool {
    return FileManager.default.fileExists(atPath: url.path)
}

func removeItem(at url: URL) {
    do {
        try FileManager.default.removeItem(at: url)
    } catch let deleteError {
        print("Error removing the item from disk: \(deleteError)")
    }
}
