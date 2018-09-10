//
//  ListImageCell.swift
//  MyEditor
//
//  Created by Do Hung on 9/4/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable
import Photos

class ListImageCell: UICollectionViewCell, NibReusable {
    private struct Constant {
        static let defaultSize = 200
    }
    
    @IBOutlet private var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContentForCell(asset: PHAsset) {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        PHImageManager.default()
            .requestImage(for: asset,
                          targetSize: CGSize(width: Constant.defaultSize, height: Constant.defaultSize),
                          contentMode: PHImageContentMode.aspectFill,
                          options: options) { [unowned self] (image, info) in
                            if let image = image,
                                let info = info,
                                let key = info["PHImageResultIsDegradedKey"] as? Int,
                                key == 0 {
                                self.imageView.image = image
                            }
        }
        
    }
}
