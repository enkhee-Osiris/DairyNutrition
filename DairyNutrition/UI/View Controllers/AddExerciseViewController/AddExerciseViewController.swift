//
//  AddExerciseViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-13.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit

class AddExerciseViewController: MainViewController, ExercisesTableProtocol{

    // MARK: Properties
    
    @IBOutlet weak var caloriesBurnedLabel: UILabel!
    
    @IBOutlet weak var exercisesTable: UITableView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Add Exercise"
        self.setupExercisesTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Custom functions
    
    func setupExercisesTableView() {
        let view = (Bundle.main.loadNibNamed("ExercisesTableSectionHeader", owner: self, options: nil)?[0] as? ExercisesTableSectionHeaderView)
        exercisesTable.tableHeaderView = view
        view?.delegate = self
    }
    
    func pushExercisesSearchViewController() {
        print("push exercise selection")
        //super.pushVC((UIStoryboard.mainStoryboard?.instantiateViewController(withIdentifier: "ExerciseAdd"))!)
    }
}
