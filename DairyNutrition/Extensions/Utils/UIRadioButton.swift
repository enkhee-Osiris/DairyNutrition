//
//  UIRadioButton.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

private let ButtonPadding: CGFloat = 50

class UIRadioButton: UIButton {
    var alternateButton:Array<UIRadioButton>?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + ButtonPadding, height: size.height)
    }
    
    /**
     Will unselect alternative buttons
     */
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:UIRadioButton in alternateButton! {
                aButton.isSelected = false
            }
        }else{
            self.toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = pinkColor?.cgColor
                self.tintColor = pinkColor
            } else {
                self.layer.borderColor = grayColor?.cgColor
                self.tintColor = grayColor
            }
        }
    }
}
