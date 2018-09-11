//
//  ImageDetailUseCase.swift
//  MyEditor
//
//  Created by Do Hung on 9/10/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import Photos
import RxSwift

protocol ImageDetailUseCaseType {
    func loadImage(asset: PHAsset) -> Observable<UIImage>
}

struct ImageDetailUseCase: ImageDetailUseCaseType {
    private struct Constant {
        static let defaultSize = 300
    }
    
    func loadImage(asset: PHAsset) -> Observable<UIImage> {
        return Observable.create { observer in
            let options = PHImageRequestOptions()
            options.deliveryMode = .highQualityFormat
            options.isNetworkAccessAllowed = true
            PHImageManager.default()
                .requestImage(for: asset,
                              targetSize: CGSize(width: Constant.defaultSize, height: Constant.defaultSize),
                              contentMode: PHImageContentMode.aspectFill,
                              options: options) { (image, info) in
                                if let image = image,
                                    let info = info,
                                    let key = info["PHImageResultIsDegradedKey"] as? Int,
                                    key == 0 {
                                    observer.onNext(image)
                                }
            }
            return Disposables.create()
        }
    }
}
