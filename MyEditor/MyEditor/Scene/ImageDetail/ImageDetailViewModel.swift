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
    }
    
    struct Output {
        let image: Driver<UIImage>
    }
    
    let image: UIImage
    
    func transform(_ input: ImageDetailViewModel.Input) -> ImageDetailViewModel.Output {
        let image = input.loadTrigger
            .map {  _ in self.image }
        return Output(
            image: image
        )
    }
}
