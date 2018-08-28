//
//  URLPhoto.swift
//  MyEditor
//
//  Created by Do Hung on 8/28/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import ObjectMapper

class URLPhoto: Mappable {
    var raw = ""
    var full = ""
    var regular = ""
    var small = ""
    var thumb = ""
    
    init() { }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        raw <- map["raw"]
        full <- map["full"]
        regular <- map["regular"]
        small <- map["small"]
        thumb <- map["thumb"]
    }
}
