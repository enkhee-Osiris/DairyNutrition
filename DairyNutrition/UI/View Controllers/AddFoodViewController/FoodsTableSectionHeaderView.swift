//
//  AddFoodSectionHeaderView.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-14.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

class FoodsTableSectionHeader: UIView {

    var delegate: FoodsTableProtocol?

    @IBAction func addFoodButtonTapped(_ sender: UIButton) {
        self.delegate?.pushFoodSearchViewController()
    }
}

protocol FoodsTableProtocol {
    func pushFoodSearchViewController()
}
