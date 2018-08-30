//
//  LibraryViewController.swift
//  MyEditor
//
//  Created by Do Hung on 8/30/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable

class LibraryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LibraryViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.library
}
