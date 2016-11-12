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
    
    // MARK: Properties
    
    var alternateButton:Array<RadioButton>?
    
    // MARK: View Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setTitleColor(pinkColor, for: .selected)
        //self.setTitleColor(pinkColor, for: .highlighted)
        self.setTitleColor(grayColor, for: .normal)
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 2.0
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = true
        self.tintColor = UIColor.white
        
    }
    
    // MARK: Touch Gesture
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    // MARK: Utilities
    
    // Will unselect alternative buttons
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
    
    func getSelectedButton() -> RadioButton? {
        if self.isSelected == false{
            if alternateButton != nil {
                for aButton:RadioButton in alternateButton! {
                    return (aButton.isSelected ? aButton : nil)!
                }
            }
            return nil
        }
        return self
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

    // Disables highlighting
    override var isHighlighted: Bool {
        didSet { if isHighlighted { isHighlighted = false } }
    }
}
