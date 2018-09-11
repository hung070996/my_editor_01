//
//  EditType.swift
//  MyEditor
//
//  Created by Do Hung on 9/10/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation

enum EditType {
    case crop, draw, brightness, contrast
    
    var item: (String, String) {
        switch self {
        case .crop:
            return ("Crop", "crop")
        case .draw:
            return ("Draw", "draw")
        case .brightness:
            return ("Brightness", "brightness")
        case .contrast:
            return ("Contrast", "contrast")
        }
    }
}
