//
//  Collection.swift
//  MyEditor
//
//  Created by Do Hung on 8/28/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import ObjectMapper

class Collection: Mappable {
    var id = 0
    var description = ""
    var title = ""
    var total = 0
    var coverPhoto = Photo()
    
    init() { }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        description <- map["description"]
        title <- map["title"]
        total <- map["total"]
        coverPhoto <- map["cover_photo"]
    }
}
