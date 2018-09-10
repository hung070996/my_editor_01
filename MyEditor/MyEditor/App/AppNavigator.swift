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
        static let iconHome = "home_unclick"
        static let iconHomeSelected = "home"
        static let iconLibrary = "library_unclick"
        static let iconLibrarySelected = "library"
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
        homeNavigationController.tabBarItem = UITabBarItem(title: Constant.home,
                                                           image: UIImage(named: Constant.iconHome)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
                                                           selectedImage: UIImage(named: Constant.iconHomeSelected)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        //Tab Library
        let libraryViewController = LibraryViewController.instantiate()
        let libraryNavigationController = UINavigationController(rootViewController: libraryViewController)
        libraryNavigationController.navigationBar.tintColor = .black
        libraryNavigationController.tabBarItem = UITabBarItem(title: Constant.library,
                                                              image: UIImage(named: Constant.iconLibrary)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
                                                              selectedImage: UIImage(named: Constant.iconLibrarySelected)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        let libraryNavigator = LibraryNavigator(navigationController: libraryNavigationController)
        let libraryUseCase = LibraryUseCase()
        let libraryViewModel = LibraryViewModel(useCase: libraryUseCase, navigator: libraryNavigator)
        libraryViewController.bindViewModel(to: libraryViewModel)
        //Tabbar
        let tabBarController = UITabBarController()
        tabBarController.addChildViewController(homeNavigationController)
        tabBarController.addChildViewController(libraryNavigationController)
        tabBarController.tabBar.tintColor = .black
        window.rootViewController = tabBarController
    }
}
