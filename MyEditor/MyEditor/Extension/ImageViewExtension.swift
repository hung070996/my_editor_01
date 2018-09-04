//
//  ImageViewExtension.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 8/30/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Kingfisher

extension UIImageView {
    func setImageForUrl(urlString: String, imageHolder: UIImage? = nil) {
        guard !urlString.isEmpty else {
            self.image = imageHolder?.withRenderingMode(.alwaysTemplate)
            self.tintColor = .white
            return
        }
        if let url = URL(string: urlString) {
            self.kf.setImage(with: url, placeholder: imageHolder, options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}

extension UIImage {
    func getImageRatio() -> CGFloat {
        let imageRatio = CGFloat(self.size.width / self.size.height)
        return imageRatio
    }
}
