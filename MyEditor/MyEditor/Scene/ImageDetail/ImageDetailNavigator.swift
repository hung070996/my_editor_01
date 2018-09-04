//
//  ImageDetailNavigator.swift
//  MyEditor
//
//  Created by Do Hung on 9/4/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import UIKit

protocol ImageDetailNavigatorType {
    func toImageDetail(image: UIImage)
}

struct ImageDetailNavigator: ImageDetailNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toImageDetail(image: UIImage) {
        let imageDetailViewController = ImageDetailViewController.instantiate()
        let imageDetailViewModel = ImageDetailViewModel(image: image)
        imageDetailViewController.bindViewModel(to: imageDetailViewModel)
        navigationController.pushViewController(imageDetailViewController, animated: true)
    }
}
