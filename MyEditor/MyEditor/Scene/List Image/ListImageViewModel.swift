//
//  ListImageViewModel.swift
//  MyEditor
//
//  Created by Do Hung on 9/4/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Photos

struct ListImageViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectImageTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let listAsset: Driver<[PHAsset]>
        let imageSelected: Driver<Void>
    }
    
    let album: Album
    let useCase: ListImageUseCase
    let navigator: ListImageNavigator
    
    func transform(_ input: ListImageViewModel.Input) -> ListImageViewModel.Output {
        let listAsset = input.loadTrigger.flatMapLatest { _ in
            return self.useCase
                .getListAsset(album: self.album)
                .asDriverOnErrorJustComplete()
        }
        let imageSelected = input.selectImageTrigger
            .withLatestFrom(listAsset) { indexPath, listAsset in
                return listAsset[indexPath.item]
            }
            .do(onNext: { asset in
                self.navigator.toImageDetail(asset: asset)
            })
            .mapToVoid()
        return Output(
            listAsset: listAsset,
            imageSelected: imageSelected
        )
    }
}
