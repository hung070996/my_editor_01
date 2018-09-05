//
//  ImageViewExtension.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 8/30/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Kingfisher
import SnapKit

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
    
    func makeCornerRadius(radius: Int = 30) {
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
    }
    
    func addBlurEffect(alpha: Float = 0.05) {
        let blurOverlay = getBlurView(style: .dark, alpha: CGFloat(alpha), superView: self)
        self.addSubview(blurOverlay)
        self.snp.remakeConstraints({ (make) in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        })
    }
}

extension UIImage {
    func getImageRatio() -> CGFloat {
        let imageRatio = CGFloat(self.size.width / self.size.height)
        return imageRatio
    }
}
