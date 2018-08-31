//
//  LibraryNavigator.swift
//  MyEditor
//
//  Created by Do Hung on 8/31/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import UIKit

protocol LibraryNavigatorType {
    func toListPhoto(in album: Album)
}

struct LibraryNavigator: LibraryNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toListPhoto(in album: Album) {
        
    }
}
