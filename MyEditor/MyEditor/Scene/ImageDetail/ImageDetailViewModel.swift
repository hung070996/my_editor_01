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

struct ImageDetailViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let clickEditTrigger: Driver<Void>
    }
    
    struct Output {
        let image: Driver<UIImage>
        let clickedEdit: Driver<Void>
    }
    
    let image: UIImage
    let navigator: ImageDetailNavigator
    
    func transform(_ input: ImageDetailViewModel.Input) -> ImageDetailViewModel.Output {
        let image = input.loadTrigger
            .map {  _ in self.image }
        let clickedEdit = input.clickEditTrigger
            .withLatestFrom(image)
            .do(onNext: self.navigator.toEditImage(image:))
            .mapToVoid()
        return Output(
            image: image,
            clickedEdit: clickedEdit
        )
    }
}
