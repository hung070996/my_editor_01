//
//  EditView.swift
//  MyEditor
//
//  Created by Do Hung on 9/6/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable

class EditView: UIView, NibOwnerLoadable {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibContent()
    }
    
    func getCollection() -> UICollectionView {
        return collectionView
    }
}
