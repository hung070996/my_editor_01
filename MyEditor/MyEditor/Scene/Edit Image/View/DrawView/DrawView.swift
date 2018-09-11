//
//  DrawView.swift
//  MyEditor
//
//  Created by Do Hung on 9/10/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import UIKit
import Reusable

protocol DrawViewDelegate: class {
    func getColor(color: UIColor)
}

class DrawView: UIView, NibOwnerLoadable {
    @IBOutlet private var undoButton: UIButton!
    @IBOutlet private var redoButton: UIButton!
    @IBOutlet private var slider: UISlider!
    @IBOutlet private var colorButtons: [UIButton]!
    weak var delegate: DrawViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibContent()
        for button in colorButtons {
            button.makeRound()
        }
    }
    
    @IBAction func clickColor(_ sender: UIButton) {
        for button in colorButtons {
            button.removeShadow()
        }
        sender.makeShadow()
        guard let color = sender.backgroundColor else {
            return
        }
        delegate?.getColor(color: color)
    }
    
    func getButtons() -> [UIButton] {
        return colorButtons
    }
    
    func getSlider() -> UISlider {
        return slider
    }
    
    func getUndoButton() -> UIButton {
        return undoButton
    }
    
    func getRedoButton() -> UIButton {
        return redoButton
    }
}
