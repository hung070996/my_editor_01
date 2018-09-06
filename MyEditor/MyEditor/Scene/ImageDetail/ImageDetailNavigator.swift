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
    func toEditImage(image: UIImage)
}

struct ImageDetailNavigator: ImageDetailNavigatorType {
    
    unowned let navigationController: UINavigationController
    
    func toImageDetail(image: UIImage) {
        let imageDetailViewController = ImageDetailViewController.instantiate()
        let imageDetailViewModel = ImageDetailViewModel(image: image,
                                                        navigator: ImageDetailNavigator(navigationController: navigationController))
        imageDetailViewController.bindViewModel(to: imageDetailViewModel)
        navigationController.pushViewController(imageDetailViewController, animated: true)
    }
    
    func toEditImage(image: UIImage) {
        let navigator = EditImageNavigator(navigationController: navigationController)
        navigator.toEditImage(image: image)
    }
}
