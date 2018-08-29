//
//  Utils.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 8/28/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit

func getBlurView(style: UIBlurEffectStyle, alpha: CGFloat, superView: UIView) -> UIVisualEffectView {
    let blurEffect = UIBlurEffect(style: style)
    let blurOverlay = UIVisualEffectView(effect: blurEffect)
    blurOverlay.alpha = alpha
    blurOverlay.frame = superView.bounds
    blurOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return blurOverlay
}

