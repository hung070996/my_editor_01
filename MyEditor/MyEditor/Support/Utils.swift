//
//  Utils.swift
//  MyEditor
//
//  Created by Can Khac Nguyen on 8/28/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import RxCocoa

fileprivate struct ConstantData {
    static let historiesKey = "Histories"
}
func getBlurView(style: UIBlurEffectStyle, alpha: CGFloat, superView: UIView) -> UIVisualEffectView {
    let blurEffect = UIBlurEffect(style: style)
    let blurOverlay = UIVisualEffectView(effect: blurEffect)
    blurOverlay.alpha = alpha
    blurOverlay.frame = superView.bounds
    blurOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return blurOverlay
}

func saveHistorySearch(histories: [String]) {
    UserDefaults.standard.set(histories, forKey: ConstantData.historiesKey)
}

func readHistorySearch() -> [String] {
    guard let result = UserDefaults.standard.array(forKey: ConstantData.historiesKey) as? [String] else {
        return [String]()
    }
    return result
}
