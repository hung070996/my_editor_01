//
//  ImageDetailNavigator.swift
//  MyEditor
//
//  Created by Do Hung on 9/4/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import UIKit
import Photos

protocol ImageDetailNavigatorType {
    func toImageDetail(asset: PHAsset)
    func toEditImage(image: UIImage)
}

struct ImageDetailNavigator: ImageDetailNavigatorType {
    
    unowned let navigationController: UINavigationController
    
    func toImageDetail(asset: PHAsset) {
        let imageDetailViewController = ImageDetailViewController.instantiate()
        let imageDetailViewModel = ImageDetailViewModel(asset: asset,
                                                        navigator: ImageDetailNavigator(navigationController: navigationController),
                                                        useCase: ImageDetailUseCase())
        imageDetailViewController.bindViewModel(to: imageDetailViewModel)
        navigationController.pushViewController(imageDetailViewController, animated: true)
    }
    
    func toEditImage(image: UIImage) {
        let navigator = EditImageNavigator(navigationController: navigationController)
        navigator.toEditImage(image: image)
    }
}
