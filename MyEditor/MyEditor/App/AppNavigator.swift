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
        //Tab Home
        let homeViewController = HomeViewController.instantiate()
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.navigationBar.tintColor = .black
        homeNavigationController.isNavigationBarHidden = true
        let homeNavigator = HomeNavigator(navigationViewController: homeNavigationController)
        let homeViewModel = HomeViewModel(navigator: homeNavigator, useCase: HomeUseCase())
        homeViewController.bindViewModel(to: homeViewModel)
        homeNavigationController.tabBarItem = UITabBarItem(title: Constant.home, image: UIImage(named: Constant.iconHome), selectedImage: UIImage(named: Constant.iconHome))
        //Tab Library
        let libraryViewController = LibraryViewController.instantiate()
        let libraryNavigationController = UINavigationController(rootViewController: libraryViewController)
        libraryNavigationController.tabBarItem = UITabBarItem(title: Constant.library, image: UIImage(named: Constant.iconLibrary), selectedImage: UIImage(named: Constant.iconLibrary))
        let libraryNavigator = LibraryNavigator(navigationController: libraryNavigationController)
        let libraryUseCase = LibraryUseCase()
        let libraryViewModel = LibraryViewModel(useCase: libraryUseCase, navigator: libraryNavigator)
        libraryViewController.bindViewModel(to: libraryViewModel)
        let tabBarController = UITabBarController()
        tabBarController.addChildViewController(homeNavigationController)
        tabBarController.addChildViewController(libraryNavigationController)
        window.rootViewController = tabBarController
    }
}
