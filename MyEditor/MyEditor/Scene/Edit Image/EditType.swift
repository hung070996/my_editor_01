//
//  EditType.swift
//  MyEditor
//
//  Created by Do Hung on 9/10/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation

enum EditType {
    case crop, draw, brightness
    
    var item: (String, String) {
        switch self {
        case .crop:
            return ("Crop", "Intro_Icon_View")
        case .draw:
            return ("Draw", "Intro_Icon_View")
        case .brightness:
            return ("Brightness", "Intro_Icon_View")
        }
    }
}
