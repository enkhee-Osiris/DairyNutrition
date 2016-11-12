//
//  CustomButton.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-08.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

@IBDesignable
class RadioButtonWithSubtext : RadioButton {
    
    // MARK: Properties
    
    var subTitle: UILabel = UILabel.init()
    
    @IBInspectable var subText: String  {
        get {
            return self.subTitle.text!
        }
        set {
            self.subTitle.text = newValue
        }
    }
    
    @IBInspectable var textColor: UIColor  {
        get {
            return self.subTitle.textColor
        }
        set {
            self.subTitle.textColor = newValue
        }
    }
    
    // MARK: View Life Cycle
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.subTitle.frame = CGRect(x: 10, y: 10, w: self.bounds.width - 10, h: self.bounds.height )
        
        self.subTitle.font = UIFont.systemFont(ofSize: 12)
        self.subTitle.lineBreakMode = .byWordWrapping
        self.subTitle.numberOfLines = 0
        
        self.addSubview(subTitle)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                subTitle.textColor = pinkColor
                self.layer.borderColor = pinkColor?.cgColor
            } else {
                subTitle.textColor = grayColor
                self.layer.borderColor = grayColor?.cgColor
            }
        }
    }
}
