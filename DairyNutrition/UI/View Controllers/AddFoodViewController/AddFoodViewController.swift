//
//  AddFoodViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-12.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import CoreData
import AlecrimCoreData


class AddFoodViewController: MainViewController, FoodsTableProtocol, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    
    @IBOutlet weak var fatLabel: UILabel!
    
    @IBOutlet weak var crabsLabel: UILabel!
    
    @IBOutlet weak var protLabel: UILabel!
    
    @IBOutlet weak var rdiLabel: UILabel!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var caloriesRemainingLabel: UILabel!
    
    @IBOutlet weak var foodsTableView: UITableView!
    
    fileprivate private(set) lazy var fetchRequestController: FetchRequestController<CoreFood> = {
        let query = persistentContainer.viewContext.foods.filter { $0.date == Date() }.orderBy{ $0.date }
        
        
        return query.toFetchRequestController()
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Add Food"

        self.setupFoodsTableView()
        
        self.fetchRequestController.bind(to: self.foodsTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Custom functions
    
    func setupFoodsTableView() {
        let view = (Bundle.main.loadNibNamed("FoodsTableSectionHeader", owner: self, options: nil)?[0] as? FoodsTableSectionHeader)
        foodsTableView.tableHeaderView = view
        view?.delegate = self
    }
    
    func pushFoodSearchViewController() {
        super.pushVC((UIStoryboard.mainStoryboard?.instantiateViewController(withIdentifier: "FoodSearchViewController"))!)
    }
    
    // MARK: - UITableViewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchRequestController.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchRequestController.numberOfObjects(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = foodsTableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        let food = self.fetchRequestController.object(at: indexPath)
        
        cell.textLabel!.text = food.name
        cell.detailTextLabel!.text = "\(Int(food.nutrients.filter{ $0.name == "Energy" }[0].value))"
        
        return cell
    }
}
