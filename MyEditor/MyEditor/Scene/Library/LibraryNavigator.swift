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
    func toListImage(in album: Album)
}

struct LibraryNavigator: LibraryNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toListImage(in album: Album) {
        let navigator = ListImageNavigator(navigationController: navigationController)
        navigator.toListImage(in: album)
    }
}
