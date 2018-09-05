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
}

struct CollectionImagesNavigator: CollectionImagesNavigatorType {
    unowned let navigationViewController: UINavigationController
    
    func toHomeScreen() {
        self.navigationViewController.popViewController(animated: true)
    }
    //MARK: NEXT_TASK
    func toImageDetailScreen() {
        print("for next task")
    }
}
