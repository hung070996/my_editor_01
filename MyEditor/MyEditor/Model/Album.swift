//
//  Album.swift
//  MyEditor
//
//  Created by Do Hung on 8/31/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import Photos

class Album: NSObject {
    let name: String
    let count: Int
    let collection: PHAssetCollection
    let latestImage: UIImage
    
    init(name: String, count: Int, collection: PHAssetCollection, latestImage: UIImage) {
        self.name = name
        self.count = count
        self.collection = collection
        self.latestImage = latestImage
    }
}
