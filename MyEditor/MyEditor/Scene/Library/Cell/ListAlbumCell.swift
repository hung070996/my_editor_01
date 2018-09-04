//
//  ListAlbumCell.swift
//  MyEditor
//
//  Created by Do Hung on 8/30/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable

class ListAlbumCell: UITableViewCell, NibReusable {
    @IBOutlet private var amountLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var iconAlbumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContentForCell(album: Album) {
        amountLabel.text = String(album.count)
        nameLabel.text = album.name
        iconAlbumImageView.image = album.latestImage
    }
}
