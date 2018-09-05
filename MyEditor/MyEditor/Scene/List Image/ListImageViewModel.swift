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
    }
    
    struct Output {
        let listImage: Driver<[UIImage]>
    }
    
    let album: Album
    let useCase: ListImageUseCase
    
    func transform(_ input: ListImageViewModel.Input) -> ListImageViewModel.Output {
        let result = input.loadTrigger.flatMapLatest { _ in
            return self.useCase.getListImage(album: self.album)
                .asDriverOnErrorJustComplete()
        }
        return Output(
            listImage: result
        )
    }
}
