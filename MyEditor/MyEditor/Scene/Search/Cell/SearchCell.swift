//
//  SearchCell.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 9/6/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable

class SearchCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var displayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillData(history: String) {
        displayLabel.text = history
    }
}
