//
//  LibraryViewController.swift
//  MyEditor
//
//  Created by Do Hung on 8/30/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class LibraryViewController: UIViewController, BindableType {
    var viewModel: LibraryViewModel!
    var loadTrigger = PublishSubject<()>()
    
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTrigger.onNext(())
    }
    
    func setupTableview() {
        tableView.register(cellType: ListAlbumCell.self)
    }
    
    func bindViewModel() {
        let input = LibraryViewModel.Input(
            loadTrigger: loadTrigger.asObserver().asDriverOnErrorJustComplete(),
            selectAlbumTrigger: tableView.rx.itemSelected.asDriver()
        )
        let output = viewModel.transform(input)
        output.listAlbums.drive(tableView.rx.items) { tableView, index, element in
            let indexPath = IndexPath(row: index, section: 0)
            let cell: ListAlbumCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setContentForCell(album: element)
            return cell
        }.disposed(by: rx.disposeBag)
        output.selectedAlbum.drive().disposed(by: rx.disposeBag)
    }
}

extension LibraryViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.library
}
