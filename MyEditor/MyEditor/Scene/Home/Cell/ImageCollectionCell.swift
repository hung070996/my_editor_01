//
//  ImageCollectionCell.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 8/29/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable

class ImageCollectionCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var displayImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func fillData(url: String, title: String) {
        displayImageView.setImageForUrl(urlString: url)
        titleLabel.text = title
    }
    
    func getImageView() -> UIImageView {
        return displayImageView
    }
}
