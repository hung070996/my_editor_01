//
//  ListImageNavigator.swift
//  MyEditor
//
//  Created by Do Hung on 9/4/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import UIKit
import Photos

protocol ListImageNavigatorType {
    func toListImage(in album: Album)
    func toImageDetail(asset: PHAsset)
}

struct ListImageNavigator: ListImageNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toListImage(in album: Album) {
        let listImageViewController = ListImageViewController.instantiate()
        let listImageViewModel = ListImageViewModel(album: album,
                                                    useCase: ListImageUseCase(),
                                                    navigator: self)
        listImageViewController.bindViewModel(to: listImageViewModel)
        navigationController.pushViewController(listImageViewController, animated: true)
    }
    
    func toImageDetail(asset: PHAsset) {
        let navigator = ImageDetailNavigator(navigationController: navigationController)
        navigator.toImageDetail(asset: asset)
    }
}
