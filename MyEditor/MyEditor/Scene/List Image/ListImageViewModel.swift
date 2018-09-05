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
        let listImage: Driver<[UIImage]>
        let imageSelected: Driver<Void>
    }
    
    let album: Album
    let useCase: ListImageUseCase
    let navigator: ListImageNavigator
    
    func transform(_ input: ListImageViewModel.Input) -> ListImageViewModel.Output {
        let listImage = input.loadTrigger.flatMapLatest { _ in
            return self.useCase.getListImage(album: self.album)
                .asDriverOnErrorJustComplete()
        }
        let imageSelected = input.selectImageTrigger
            .withLatestFrom(listImage) { indexPath, listImage in
            self.navigator.toImageDetail(image: listImage[indexPath.row])
        }
        return Output(
            listImage: listImage,
            imageSelected: imageSelected
        )
    }
}
