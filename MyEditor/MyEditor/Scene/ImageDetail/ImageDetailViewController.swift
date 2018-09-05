//
//  ImageDetailViewController.swift
//  MyEditor
//
//  Created by Do Hung on 9/4/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift

class ImageDetailViewController: UIViewController, BindableType {

    @IBOutlet private var imageView: UIImageView!
    
    var viewModel: ImageDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        let input = ImageDetailViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input)
        output.image
            .drive(imageView.rx.image)
            .disposed(by: rx.disposeBag)
    }
}

extension ImageDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.imageDetail
}
