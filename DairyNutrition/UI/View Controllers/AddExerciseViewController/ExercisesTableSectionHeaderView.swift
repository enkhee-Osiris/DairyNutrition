//
//  ExercisesTableSectionHeaderView.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-14.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

class ExercisesTableSectionHeaderView: UIView {

    var delegate: ExercisesTableProtocol?

    @IBAction func addExercisesButtonTapped(_ sender: UIButton) {
        self.delegate?.pushExercisesSearchViewController()
    }
}

protocol ExercisesTableProtocol {
    func pushExercisesSearchViewController()
}
