//
//  ImageTableCell.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 8/29/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

class ImageTableCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var displayImageView: UIImageView!
    @IBOutlet private weak var authorLabel: UILabel!
    
    func fillData(url: String, author: String) {
        displayImageView.setNeedsLayout()
        displayImageView.setImageForUrl(urlString: url, imageHolder: #imageLiteral(resourceName: "Intro_Background_Home"))
        authorLabel.text = author
    }
}
