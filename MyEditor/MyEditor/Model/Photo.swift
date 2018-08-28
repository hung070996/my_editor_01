//
//  Photo.swift
//  MyEditor
//
//  Created by Do Hung on 8/28/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import ObjectMapper

class Photo: Mappable {
    var id = 0
    var description = ""
    var width = 0
    var height = 0
    var urls = URLPhoto()
    var like = 0
    
    init() { }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        description <- map["description"]
        width <- map["width"]
        height <- map["height"]
        urls <- map["urls"]
        like <- map["like"]
    }
}
