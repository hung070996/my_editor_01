//
//  ListImageUseCase.swift
//  MyEditor
//
//  Created by Do Hung on 9/4/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import RxSwift
import Photos

protocol ListImageUseCaseType {
    func getListAsset(album: Album) -> Observable<[PHAsset]>
}

struct ListImageUseCase: ListImageUseCaseType {
    private struct Constant {
        static let defaultSize = 250
    }
    
    func getListAsset(album: Album) -> Observable<[PHAsset]> {
        return Observable.create { observer in
            var listAsset = [PHAsset]()
            let assets = PHAsset.fetchAssets(in: album.collection, options: nil)
            for i in 0 ..< assets.count {
                let asset = assets.object(at: assets.count - 1 - i)
                listAsset.append(asset)
            }
            observer.onNext(listAsset)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
