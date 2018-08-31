//
//  LibraryUseCase.swift
//  MyEditor
//
//  Created by Do Hung on 8/31/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import RxSwift

protocol LibraryUseCaseType {
    func getAlbums() -> Observable<[Album]>
}

struct LibraryUseCase: LibraryUseCaseType {
    func getAlbums() -> Observable<[Album]> {
        return LibraryRepository().getListAlbum()
    }
}
