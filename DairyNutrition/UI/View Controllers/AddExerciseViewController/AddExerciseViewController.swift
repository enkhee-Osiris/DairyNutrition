//
//  AddExerciseViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-13.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import CoreData
import AlecrimCoreData

class AddExerciseViewController: MainViewController, ExercisesTableProtocol, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    
    @IBOutlet weak var caloriesBurnedLabel: UILabel!
    
    @IBOutlet weak var exercisesTable: UITableView!
    
    @IBOutlet weak var exercisesTableHeightConstraint: NSLayoutConstraint!
    
    fileprivate private(set) lazy var fetchRequestController: FetchRequestController<CoreExercise> = {
        let query = persistentContainer.viewContext.exercises.filter{ $0.date == Shared.shared.selectedDate }.orderBy{ $0.name }
        
        print("\(persistentContainer.viewContext.exercises.orderBy{ $0.date }.map{ $0.date })")
        
        return query.toFetchRequestController()
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Add Exercise"
        
        self.fetchRequestController.bind(to: self.exercisesTable)
        self.setupExercisesTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let rowHeight = CGFloat(44)
        let headerHeight = exercisesTable.sectionHeaderHeight
        let count = self.fetchRequestController.numberOfObjects(inSection: 0) == 0 ? 1 : self.fetchRequestController.numberOfObjects(inSection: 0)
        
        let height = (CGFloat(count) * rowHeight) + headerHeight
        self.exercisesTableHeightConstraint.constant = height
        
        if((self.fetchRequestController.fetchedObjects?.count)! > 0) {
            
            let calories = self.fetchRequestController.fetchedObjects?.flatMap{ $0.value }
            
            let sum = Int((calories?.reduce(0, +))!)
            
            self.caloriesBurnedLabel.text = "\(sum)"
        }
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
        super.pushVC((UIStoryboard.mainStoryboard?.instantiateViewController(withIdentifier: "ExerciseSearchViewController"))!)
    }
}

// MARK: - UITableViewDelegate

extension AddExerciseViewController {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchRequestController.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchRequestController.numberOfObjects(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = exercisesTable.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)
        
        let exercise = self.fetchRequestController.object(at: indexPath)
        
        cell.textLabel!.text = exercise.name
        let calories = exercise.value
        cell.detailTextLabel!.text = "\(calories)"
        
        return cell
    }
}

