//
//  IBDesignable+Button.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-10-31.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

private let ButtonPadding: CGFloat = 50

@IBDesignable class DesignableButton: UIButton {
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + ButtonPadding, height: size.height)
    }
}
