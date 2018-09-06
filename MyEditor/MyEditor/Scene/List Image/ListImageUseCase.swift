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
    func getListImage(album: Album) -> Observable<[UIImage]>
}

struct ListImageUseCase: ListImageUseCaseType {
    private struct Constant {
        static let defaultSize = 250
    }
    
    func getListImage(album: Album) -> Observable<[UIImage]> {
        return Observable.create { observer in
            var listImage = [UIImage]()
            let assets = PHAsset.fetchAssets(in: album.collection, options: nil)
            for i in 0 ..< assets.count {
                let asset = assets.object(at: assets.count - 1 - i)
                PHImageManager.default()
                    .requestImage(for: asset,
                                  targetSize: CGSize(width: Constant.defaultSize, height: Constant.defaultSize),
                                  contentMode: PHImageContentMode.aspectFill,
                                  options: nil) { (image, info) in
                                    if let image = image,
                                        let info = info,
                                        let key = info["PHImageResultIsDegradedKey"] as? Int,
                                        key == 0 {
                                        listImage.append(image)
                                        observer.onNext(listImage)
                                    }
                }
            }
            return Disposables.create()
        }
    }
}
