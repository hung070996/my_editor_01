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
        static let defaultSize = 100
    }
    
    func getListImage(album: Album) -> Observable<[UIImage]> {
        var listImage = [UIImage]()
        let assets = PHAsset.fetchAssets(in: album.collection, options: nil)
        for i in 0 ..< assets.count {
            let asset = assets.object(at: assets.count - 1 - i)
            PHImageManager.default()
                .requestImage(for: asset,
                              targetSize: CGSize(width: Constant.defaultSize, height: Constant.defaultSize),
                              contentMode: PHImageContentMode.aspectFill,
                              options: nil) { (image, _) in
                                guard let image = image else {
                                    return
                                }
                                listImage.append(image)
            }
        }
        return Observable.just(listImage)
    }
}
