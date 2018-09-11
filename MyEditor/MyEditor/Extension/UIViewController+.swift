//
//  UIViewController+.swift
//  MyEditor
//
//  Created by Do Hung on 8/28/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

extension UIViewController {
    func showAlertError(message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showToast(message : String) {
        let toastWidth = 250
        let toastHeight = 35
        let toastLabel = UILabel(frame: CGRect(x: Int(self.view.frame.size.width / 2) - Int(toastWidth / 2),
                                               y: Int(self.view.frame.size.height - 100),
                                               width: toastWidth, height: toastHeight))
        toastLabel.backgroundColor = UIColor.orange.withAlphaComponent(0.9)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { isCompleted in
            toastLabel.removeFromSuperview()
        })
    }
    
    func makeToastWindow(title: String) {
        let window = UIApplication.shared.keyWindow
        window?.rootViewController?.view.makeToast(title)
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
}
