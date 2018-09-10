//
//  PHPhotoLibrary+SaveImage.swift
//  MyEditor
//
//  Created by Do Hung on 8/29/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import UIKit
import Photos
import RxSwift
import NSObject_Rx

extension PHPhotoLibrary {
    func findAlbum(albumName: String) -> Observable<PHAssetCollection> {
        return Observable.create({ subcriber in
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
            let fetchResult : PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
            guard let photoAlbum = fetchResult.firstObject else {
                _ = PHPhotoLibrary.shared()
                    .createAlbum(albumName: albumName)
                    .subscribe(onNext: { (collection) in
                    subcriber.onNext(collection)
                }, onError: { (error) in
                    subcriber.onError(BaseError.unexpectedError)
                })
                return Disposables.create()
            }
            subcriber.onNext(photoAlbum)
            return Disposables.create()
        })
    }
    
    func createAlbum(albumName: String) -> Observable<PHAssetCollection> {
        return Observable.create({ (observer) -> Disposable in
            var albumPlaceholder: PHObjectPlaceholder?
            PHPhotoLibrary.shared().performChanges({
                let createAlbumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumName)
                albumPlaceholder = createAlbumRequest.placeholderForCreatedAssetCollection
            }, completionHandler: { success, error in
                if success {
                    guard let placeholder = albumPlaceholder else {
                        observer.onError(BaseError.unexpectedError)
                        return
                    }
                    let fetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
                    guard let album = fetchResult.firstObject else {
                        observer.onError(BaseError.unexpectedError)
                        return
                    }
                    observer.onNext(album)
                } else {
                    observer.onError(BaseError.unexpectedError)
                }
            })
            return Disposables.create()
        })
    }
    
    func saveImage(image: UIImage, album: PHAssetCollection) -> Observable<Bool> {
        return Observable.create({ observer in
            var placeholder: PHObjectPlaceholder?
            PHPhotoLibrary.shared().performChanges({
                let createAssetRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                guard let albumChangeRequest = PHAssetCollectionChangeRequest(for: album),
                    let photoPlaceholder = createAssetRequest.placeholderForCreatedAsset else { return }
                placeholder = photoPlaceholder
                let fastEnumeration = NSArray(array: [photoPlaceholder] as [PHObjectPlaceholder])
                albumChangeRequest.addAssets(fastEnumeration)
            }, completionHandler: { success, error in
                guard let _ = placeholder else {
                    observer.onError(BaseError.unexpectedError)
                    return
                }
                observer.onNext(success ? true : false)
            })
            return Disposables.create()
        })
    }
}
