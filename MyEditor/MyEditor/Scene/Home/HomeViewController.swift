//
//  HomeViewController.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 8/29/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable
import Then
import RxCocoa

class HomeViewController: UIViewController, BindableType {
    @IBOutlet weak var exploreCollectionView: LoadMoreCollectionView!
    @IBOutlet weak var photosTableView: RefreshTableView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var topView: UIView!
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        photosTableView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
        photosTableView.do {
            $0.estimatedRowHeight = 100
            $0.rowHeight = UITableViewAutomaticDimension
            $0.register(cellType: ImageTableCell.self)
        }
        exploreCollectionView.do {
            $0.register(cellType: ImageCollectionCell.self)
        }
        exploreCollectionView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
    }
    
    func bindViewModel() {
        let input = HomeViewModel.Input(
            loadTrigger: Driver.just(()),
            loadCollectionTrigger:  Driver.never(),
            reloadTableViewTrigger: Driver.never(),
            loadMoreTableViewTrigger: photosTableView.loadMoreBottomTrigger,
            reloadCollectionViewTrigger: exploreCollectionView.loadMoreTrigger,
            loadMoreCollectionViewTrigger: exploreCollectionView.loadMoreTrigger,
            selectTableViewTrigger: photosTableView.rx.itemSelected.asDriver(),
            selectCollectionViewTrigger: exploreCollectionView.rx.itemSelected.asDriver()
        )
        
        let output = viewModel.transform(input)
        output.photos
            .drive(photosTableView.rx.items) { tableView, index, photo in
                let indexPath = IndexPath(row: index, section: 0)
                let cell = tableView.dequeueReusableCell(for: indexPath) as ImageTableCell
                cell.fillData(url: photo.urls.regular, author: photo.id + "")
                return cell
            }
            .disposed(by: rx.disposeBag)
        output.collections
            .drive(exploreCollectionView.rx.items) { collectionView, index, collection in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = collectionView.dequeueReusableCell(for: indexPath) as ImageCollectionCell
                cell.fillData(url: collection.coverPhoto.urls.full, title: collection.title)
                return cell
            }
            .disposed(by: rx.disposeBag)
        output.errorTableView
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        output.errorCollectionView
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        output.isEmptyPhotoData
            .drive()
            .disposed(by: rx.disposeBag)
        output.isEmptyCollectionData
            .drive()
            .disposed(by: rx.disposeBag)
        output.fetchItemsTableView
            .drive()
            .disposed(by: rx.disposeBag)
        output.fetchItemsCollectionView
            .drive()
            .disposed(by: rx.disposeBag)
        output.loadingTableView
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        output.loadingCollectionView
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        output.refreshing
            .drive(photosTableView.loadingMoreTop)
            .disposed(by: rx.disposeBag)
        output.refreshingCollectionView
            .drive(exploreCollectionView.refreshing)
            .disposed(by: rx.disposeBag)
        output.loadingMoreTableView
            .drive(photosTableView.loadingMoreBottom)
            .disposed(by: rx.disposeBag)
        output.loadingCollectionView
            .drive(exploreCollectionView.loadingMore)
            .disposed(by: rx.disposeBag)
    }
}

extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.home
}

extension HomeViewController: UICollectionViewDelegate {
    
}
