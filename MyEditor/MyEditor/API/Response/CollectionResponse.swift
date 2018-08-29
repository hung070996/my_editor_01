//
//  CollectionResponse.swift
//  MyEditor
//
//  Created by Do Hung on 8/29/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import ObjectMapper

class CollectionResponse: Mappable {
    var listCollections = [Collection]()
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        listCollections <- map
    }
}
