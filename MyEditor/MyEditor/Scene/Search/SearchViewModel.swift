//
//  SearchViewModel.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 9/6/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxGesture

struct SearchViewModel: ViewModelType {
    struct Input {
        let toHomeTrigger: Driver<Void>
        let cancelKeyboardTrigger: Driver<Void>
        let searchTrigger: Driver<String>
        let selectTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let resultSearchQuery: Driver<String>
        let resultCancelKeyboard: Driver<Void>
        let sectionedSuggest: Driver<[SuggestSection]>
    }
    
    var navigator: SearchNavigatorType
    var useCase: SearchUseCase
    let disposeBag = DisposeBag()
    //arrTrending is a constant array
    let arrTrending = ["krishna", "girls", "4k wallpaper", "mehndi", "fall"]
    struct SuggestSection {
        let header: String
        let productList: [String]
    }
    
    func transform(_ input: Input) -> Output {
        input.toHomeTrigger.asObservable().subscribe(onNext: {
                self.navigator.toHomeScreen()
            })
            .disposed(by: disposeBag)
        input.selectTrigger.asObservable().subscribe(onNext: { indexPath in
                self.navigator.toCollectionImagesScreen(collection: Collection())
            })
            .disposed(by: disposeBag)
        var arrHistory = [String]()
        let driverRelay = BehaviorRelay<[String]>(value: arrHistory)
        input.searchTrigger.drive(onNext: { text in
            arrHistory.append(text)
            driverRelay.accept(arrHistory)
        })
        .disposed(by: disposeBag)
        let sectioned = driverRelay
            .map { [
                    SuggestSection(header: "History", productList: $0),
                    SuggestSection(header: "Trending", productList: self.arrTrending)
                ] }
            .asDriverOnErrorJustComplete()
        return Output(
            resultSearchQuery: input.searchTrigger,
            resultCancelKeyboard: input.cancelKeyboardTrigger,
            sectionedSuggest: sectioned
        )
    }
}
