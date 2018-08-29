//
//  ImageTableCell.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 8/29/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable

class ImageTableCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var displayImageView: UIImageView!
    @IBOutlet private weak var authorLabel: UILabel!
}
