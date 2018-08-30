//
//  AppNavigator.swift
//  MyEditor
//
//  Created by Do Hung on 8/30/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import UIKit
import Reusable

protocol AppNavigatorType {
    func start()
}

struct AppNavigator: AppNavigatorType {
    private struct Constant {
        static let home = "Home"
        static let library = "Library"
        static let iconHome = "Intro_Icon_Home"
        static let iconLibrary = "Intro_Icon_List"
    }
    
    unowned let window: UIWindow
    
    func start() {
        let homeViewController = HomeViewController.instantiate()
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.tabBarItem = UITabBarItem(title: Constant.home, image: UIImage(named: Constant.iconHome), selectedImage: UIImage(named: Constant.iconHome))
        let libraryViewController = LibraryViewController.instantiate()
        let libraryNavigationController = UINavigationController(rootViewController: libraryViewController)
        libraryNavigationController.tabBarItem = UITabBarItem(title: Constant.library, image: UIImage(named: Constant.iconLibrary), selectedImage: UIImage(named: Constant.iconLibrary))
        let tabBarController = UITabBarController()
        tabBarController.addChildViewController(homeNavigationController)
        tabBarController.addChildViewController(libraryNavigationController)
        window.rootViewController = tabBarController
    }
}
