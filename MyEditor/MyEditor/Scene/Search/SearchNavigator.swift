//
//  SearchNavigator.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 9/6/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit

protocol SearchNavigatorType {
    func toSearchScreen()
    func toHomeScreen()
    func toCollectionImagesScreen(collection: Collection)
}

struct SearchNavigator: SearchNavigatorType {
    unowned let navigationViewController: UINavigationController
    
    func toSearchScreen() {
        let vc = SearchViewController.instantiate()
        let model = SearchViewModel(navigator: self, useCase: SearchUseCase())
        vc.bindViewModel(to: model)
        self.navigationViewController.pushViewController(vc, animated: true)
    }
    
    func toHomeScreen() {
        self.navigationViewController.popViewController(animated: true)
    }
    //TODO: NEXT_TASK
    func toCollectionImagesScreen(collection: Collection) {
    }
}
