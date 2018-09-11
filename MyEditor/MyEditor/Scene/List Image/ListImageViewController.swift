//
//  ListImageViewController.swift
//  MyEditor
//
//  Created by Do Hung on 9/4/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class ListImageViewController: UIViewController, BindableType {
    var viewModel: ListImageViewModel!
    
    @IBOutlet private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionview()
    }
    
    func setupCollectionview() {
        collectionView.register(cellType: ListImageCell.self)
    }
    
    func bindViewModel() {
        let input = ListImageViewModel.Input(loadTrigger: Driver.just(()),
                                             selectImageTrigger: collectionView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input)
        output.listAsset
            .drive(collectionView.rx.items) { collectionView, index, element in
            let indexPath = IndexPath(item: index, section: 0)
            let cell: ListImageCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setContentForCell(asset: element)
            return cell
        }
            .disposed(by: rx.disposeBag)
        output.imageSelected
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension ListImageViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.listImage
}
