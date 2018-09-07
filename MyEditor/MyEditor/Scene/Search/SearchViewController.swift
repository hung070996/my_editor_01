//
//  SearchViewController.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 9/6/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import RxGesture
import RxDataSources

class SearchViewController: UIViewController, BindableType {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet weak var searchTableView: UITableView!
    
    var viewModel: SearchViewModel!
    var querryObservable: Observable<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    fileprivate typealias SuggestSectionModel = SectionModel<String, String>
    fileprivate let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(
        configureCell: { (dataSource, tableView, indexPath, data) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(for: indexPath) as SearchCell
            cell.fillData(history: data)
            return cell
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
//            return dataSource[sectionIndex].model
            return ""
        }
    )
    
    func configView() {
        searchTableView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
        searchTableView.do {
            $0.estimatedRowHeight = 80
            $0.rowHeight = UITableViewAutomaticDimension
            $0.register(cellType: SearchCell.self)
            $0.register(headerFooterViewType: SearchHeader.self)
            $0.separatorStyle = .none
        }
        querryObservable = searchBar.rx.textDidEndEditing.asObservable()
                    .withLatestFrom(searchBar.rx.text.orEmpty.asObservable())
    }
    
    func bindViewModel() {
        let input = SearchViewModel.Input(
            toHomeTrigger: cancelButton.rx.tap.asDriver(),
            cancelKeyboardTrigger: searchTableView.rx
                .anyGesture(.swipe([.up, .down]))
                .when(.recognized)
                .mapToVoid()
                .asDriverOnErrorJustComplete(),
            searchTrigger: querryObservable.asDriverOnErrorJustComplete(),
            selectTrigger: searchTableView.rx.itemSelected.asDriverOnErrorJustComplete()
        )
        let output = viewModel.transform(input)
        output.resultCancelKeyboard
            .drive(onNext: { [unowned self] _ in
                self.dismissKeyboard()
            })
            .disposed(by: rx.disposeBag)
        output.resultSearchQuery
            .drive(onNext: { str in
                //TODO: NEXT_TASK
                print(str)
            })
            .disposed(by: rx.disposeBag)
        output.sectionedSuggest
            .map { $0.map { section in
                    SuggestSectionModel(model: section.header, items: section.productList)
                }
            }
            .drive(searchTableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
    }
}

extension SearchViewController: StoryboardSceneBased {
    static let sceneStoryboard = Storyboards.search
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(SearchHeader.self)
        header?.sectionLabel.text = dataSource.sectionModels[section].model
        return header
    }
}

extension SearchViewController: UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
