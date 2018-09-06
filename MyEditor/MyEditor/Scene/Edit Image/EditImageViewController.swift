//
//  EditImageViewController.swift
//  MyEditor
//
//  Created by Do Hung on 9/6/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class EditImageViewController: UIViewController, BindableType {
    
    var viewModel: EditImageViewModel!

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var editView: EditView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        let input = EditImageViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input)
        output.image
            .drive(imageView.rx.image)
            .disposed(by: rx.disposeBag)
    }
}

extension EditImageViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.editImage
}
