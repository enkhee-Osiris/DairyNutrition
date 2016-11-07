//
//  RadioButton.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

@IBDesignable
class RadioButton: UIButton {
    var alternateButton:Array<RadioButton>?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setTitleColor(pinkColor, for: .selected)
        self.setTitleColor(grayColor, for: .normal)
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 2.0
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    /**
     Will unselect alternative buttons
     */
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        }else{
            self.toggleButton()
        }
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = pinkColor?.cgColor
            } else {
                self.layer.borderColor = grayColor?.cgColor
            }
        }
    }

}
