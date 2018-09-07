//
//  EditImageUseCase.swift
//  MyEditor
//
//  Created by Do Hung on 9/10/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Photos

protocol EditImageUseCaseType {
    func saveImage(image: UIImage) -> Observable<Bool>
}

struct EditImageUseCase: EditImageUseCaseType {
    private struct Constant {
        static let albumName = "MyEditor"
    }
    
    func saveImage(image: UIImage) -> Observable<Bool> {
        return PHPhotoLibrary.shared()
            .findAlbum(albumName: Constant.albumName)
            .flatMapLatest { collection in
                return PHPhotoLibrary.shared().saveImage(image: image, album: collection)
        }
    }
}
