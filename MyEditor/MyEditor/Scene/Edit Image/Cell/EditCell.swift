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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContentForCell(title: String, image: String) {
        label.text = title
        let image = UIImage(named: image)
        imageView.image = image
    }
}
