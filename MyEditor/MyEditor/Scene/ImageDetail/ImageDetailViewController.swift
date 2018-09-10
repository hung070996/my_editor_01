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
    var editItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupView() {
        editItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = editItem
    }
    
    func bindViewModel() {
        let input = ImageDetailViewModel.Input(loadTrigger: Driver.just(()),
                                               clickEditTrigger: editItem.rx.tap.asDriver())
        let output = viewModel.transform(input)
        output.image
            .drive(imageView.rx.image)
            .disposed(by: rx.disposeBag)
        output.clickedEdit.drive().disposed(by: rx.disposeBag)
    }
}

extension ImageDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.imageDetail
}
