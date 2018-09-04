//
//  LibraryViewModel.swift
//  MyEditor
//
//  Created by Do Hung on 8/31/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct LibraryViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectAlbumTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let listAlbums: Driver<[Album]>
        let selectedAlbum: Driver<Void>
    }
    
    let useCase: LibraryUseCaseType
    let navigator: LibraryNavigator
    
    func transform(_ input: LibraryViewModel.Input) -> LibraryViewModel.Output {
        let errorTracker = ErrorTracker()
        let listAlbum = input.loadTrigger
            .flatMapLatest { _ in
                return self.useCase.getAlbums()
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        let selectedAlbum = input.selectAlbumTrigger
            .withLatestFrom(listAlbum) { indexPath, listAlbum in
                self.navigator.toListImage(in: listAlbum[indexPath.row])
            }
            .mapToVoid()
        
        return Output(
            listAlbums: listAlbum,
            selectedAlbum: selectedAlbum
        )
    }
}

