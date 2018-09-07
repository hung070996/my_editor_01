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
    
    func removeAllEffect() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func addBlurEffect(alpha: Float = 0.2) {
        removeAllEffect()
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
    
    func crop(rect: CGRect) -> UIImage {
        var rect = rect
        rect.origin.x *= self.scale
        rect.origin.y *= self.scale
        rect.size.width *= self.scale
        rect.size.height *= self.scale
        guard let cgImage = self.cgImage, let imageRef = cgImage.cropping(to: rect) else {
            return UIImage()
        }
        let image = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        return image
    }
    
    func resize(scaledTo newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
