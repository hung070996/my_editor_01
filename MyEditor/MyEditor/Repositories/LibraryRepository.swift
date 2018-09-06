//
//  LibraryRepository.swift
//  MyEditor
//
//  Created by Do Hung on 8/31/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import RxSwift
import Photos

protocol LibraryRepositoryType {
    func getListAlbum() -> Observable<[Album]>
}

final class LibraryRepository: LibraryRepositoryType {
    private struct Constant {
        static let defaultSize = 200
    }
    
    func getListAlbum() -> Observable<[Album]> {
        return Observable.create { observer in
            var albums = [Album]()
            let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
            let topLevelUserCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
            let allAlbums = [topLevelUserCollections, smartAlbums]
            for i in 0 ..< allAlbums.count {
                let result = allAlbums[i]
                (result as AnyObject).enumerateObjects { (asset, index, stop) -> Void in
                    guard let album = asset as? PHAssetCollection else {
                        return
                    }
                    let assets = PHAsset.fetchAssets(in: album, options: nil)
                    guard let _ = assets.firstObject else {
                        return
                    }
                    PHImageManager.default()
                        .requestImage(for: assets[assets.count - 1],
                                      targetSize: CGSize(width: Constant.defaultSize, height: Constant.defaultSize),
                                      contentMode: PHImageContentMode.aspectFit,
                                      options: nil,
                                      resultHandler: { (result, info) in
                                        if let image = result,
                                            let info = info,
                                            let key = info["PHImageResultIsDegradedKey"] as? Int,
                                            let title = album.localizedTitle,
                                            key == 0 {
                                            let newAlbum = Album(name: title, count: assets.count, collection: album, latestImage: image)
                                            albums.append(newAlbum)
                                            observer.onNext(albums)
                                        }
                    })
                }
            }
            return Disposables.create()
        }
    }
}
