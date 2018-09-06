//
//  CollectionImageNavigator.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 9/5/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit

protocol CollectionImagesNavigatorType {
    func toHomeScreen()
    func toImageDetailScreen()
    func toCollectionImagesScreen(collection: Collection)
}

struct CollectionImagesNavigator: CollectionImagesNavigatorType {
    unowned let navigationViewController: UINavigationController
    
    func toCollectionImagesScreen(collection: Collection) {
        let vc = CollectionImageViewController.instantiate()
        let model = CollectionImagesViewModel(navigator: self, useCase: CollectionImagesUseCase(), collection: collection)
        vc.bindViewModel(to: model)
        self.navigationViewController.pushViewController(vc, animated: true)
    }
    
    func toHomeScreen() {
        
        self.navigationViewController.popViewController(animated: true)
    }
    // TODO: - NEXT_TASK
    func toImageDetailScreen() {
        print("for next task")
    }
}
