//
//  EditCell.swift
//  MyEditor
//
//  Created by Do Hung on 9/6/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable

class EditCell: UICollectionViewCell, NibReusable {
    @IBOutlet private var label: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContentForCell(type: EditType) {
        label.text = type.item.0
        let image = UIImage(named: type.item.1)
        imageView.image = image
        mainView.makeShadow()
    }
}
