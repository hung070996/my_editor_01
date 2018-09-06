//
//  EditImageViewModel.swift
//  MyEditor
//
//  Created by Do Hung on 9/6/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Photos

struct EditImageViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let image: Driver<UIImage>
    }
    
    let image: UIImage
    
    func transform(_ input: EditImageViewModel.Input) -> EditImageViewModel.Output {
        let image = input.loadTrigger
            .map {  _ in self.image }
        return Output(
            image: image
        )
    }
}
